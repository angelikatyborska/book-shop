require 'logger'

class RpcProvider
  def initialize(rabbitmq_config)
    @logger = Logger.new(STDOUT)
    @connection = Bunny.new(rabbitmq_config.symbolize_keys)

    try_connect

    @channel = @connection.create_channel
    @queues = {}
  end

  def register_queue(routing_key, &block)
    @queues[routing_key] = @channel.queue(routing_key)
    @queues[routing_key].subscribe do |delivery_info, properties, payload|
      @logger.info("Received request for #{routing_key}")
      reponse = block.call
      @logger.info("Responding to #{properties[:reply_to]} with #{reponse}")
      @channel.default_exchange.publish(
        reponse,
        routing_key: properties[:reply_to],
        correlation_id: properties[:correlation_id],
      )
    end

    @logger.info("Registered handler for queue #{routing_key}")
  end

  def close
    @channel.close
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
