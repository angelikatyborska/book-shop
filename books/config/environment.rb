# This file is for initialization of dependencies like RabbitMQ or PostgreSQL
require_relative './application'
require 'yaml'
require 'erb'

APP_ENV = ENV['APP_ENV'] || 'development'

template = ERB.new File.read('config/database.yml')
database_config = YAML.load(template.result)[APP_ENV]

ActiveRecord::Base.establish_connection(database_config)
