require 'uuid'
require 'thread'
require 'logger'

class RpcClient
  attr_reader :lock, :condition
  attr_accessor :response, :correlation_id

  def initialize(rabbitmq_config)
    @lock = Mutex.new
    @condition = ConditionVariable.new

    @logger = Logger.new(STDOUT)
    @connection = Bunny.new(rabbitmq_config.symbolize_keys)

    try_connect

    @channel = @connection.create_channel
    @reply_queue = @channel.queue(UUID.generate, exclusive: true, auto_delete: true)

    that = self

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

    @logger.info("Waiting for RPC #{routing_key} (#{@correlation_id})")

    @lock.synchronize { @condition.wait(@lock) }

    @logger.info("Received response for RPC #{routing_key} (#{@correlation_id}): #{@response}")

    @response
  end

  private

  def try_connect
    @connection_retry ||= 0
    @connection.start
    @logger.info('Connected to RabbitMQ')
  rescue Bunny::TCPConnectionFailedForAllHosts => e
    @logger.warn("Connection attempt to RabbitMQ no #{@connection_retry} failed")
    @connection_retry += 1
    sleep 2 ** @connection_retry
    try_connect
  end
end
