require 'uuid'
require 'thread'
require 'logger'

class RpcClient
  attr_reader :lock, :conditions, :responses

  def initialize(connection)
    @lock = Mutex.new
    @conditions = {}
    @responses = {}

    @logger = Logger.new(STDOUT)
    @connection = connection

    @channel = @connection.create_channel
    @reply_queue = @channel.queue(UUID.generate, exclusive: true, auto_delete: true)

    that = self

    @reply_queue.subscribe do |delivery_info, properties, payload|
      if that.conditions[properties[:correlation_id]]
        that.responses[properties[:correlation_id]] = payload
        that.lock.synchronize { that.conditions.delete(properties[:correlation_id]).signal }
      else
        @logger.error("Discarding message #{payload.inspect} (correlation: #{properties[:correlation_id].inspect})")
      end
    end
  end

  def get(routing_key)
    correlation_id = UUID.generate

    @channel.default_exchange.publish(
      '',
      routing_key: routing_key,
      correlation_id: correlation_id,
      reply_to: @reply_queue.name
    )

    @conditions[correlation_id] = ConditionVariable.new

    @logger.info("Waiting for RPC #{routing_key} (#{correlation_id})")

    @lock.synchronize { @conditions[correlation_id].wait(@lock) }


    response = @responses.delete(correlation_id)
    @logger.info("Received response for RPC #{routing_key} (#{correlation_id}): #{response}")
    response
  end
end
