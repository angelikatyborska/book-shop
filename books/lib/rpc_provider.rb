require 'logger'

class RpcProvider
  def initialize(rabbitmq_config)
    @connection = Bunny.new(rabbitmq_config)
    @connection.start

    @channel = @connection.create_channel

    @queues = {}
    @logger = Logger.new(STDOUT)
  end

  def register_queue(routing_key, &block)
    @queues[routing_key] = @channel.queue(routing_key)
    @queues[routing_key].subscribe do |delivery_info, properties, payload|
      reponse = block.call
      @logger.info("Received request for #{routing_key}")
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
end
