require 'uuid'
require 'thread'

class RPC # FIXME: this probably goes to /lib, or possibly into a gem and could be shared
  attr_reader :lock, :condition
  attr_accessor :response, :correlation_id

  def initialize
    config = Rails.application.config_for(:rabbitmq)

    @lock = Mutex.new
    @condition = ConditionVariable.new

    @connection = Bunny.new(config)
    @connection.start

    @channel = @connection.create_channel
    @reply_queue = @channel.queue(UUID.generate, exclusive: true, auto_delete: true)

    that = self # ?

    @reply_queue.subscribe do |delivery_info, properties, payload|
      if that.correlation_id == properties[:correlation_id]
        that.response = payload
        that.lock.synchronize { that.condition.signal }
      end
    end
  end

  def get(routing_key)
    @correlation_id = UUID.generate

    @channel.default_exchange.publish(
      '',
      routing_key: routing_key,
      correlation_id: @correlation_id,
      reply_to: @reply_queue.name
    )

    @lock.synchronize { @condition.wait(@lock) }
    @response
  end
end

rpc = RPC.new

::RpcClient = rpc # FIXME: figure out proper names
# FIXME: is there a better way to share this with the controllers?