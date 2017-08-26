RABBIT_MQ_CONNECTION = Bunny.new(Rails.application.config_for(:rabbitmq).symbolize_keys)

connection_retry = 0

begin
  RABBIT_MQ_CONNECTION.start
  Rails.logger.info('Connected to RabbitMQ')
rescue Bunny::TCPConnectionFailedForAllHosts => e
  Rails.logger.warn("Connection attempt to RabbitMQ no #{connection_retry} failed")
  connection_retry += 1
  sleep 2 ** connection_retry
  retry
end
