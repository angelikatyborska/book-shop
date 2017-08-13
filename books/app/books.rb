class Books
  def self.env
    ENV['APP_ENV'] || 'development'
  end

  def self.read_config(name)
    template = ERB.new File.read("config/#{name}.yml")
    YAML.load(template.result)[env].symbolize_keys
  end

  def self.rabbitmq_config
    read_config('rabbitmq')
  end

  def self.database_config
    read_config('database')
  end
end
