# This file is for initialization of dependencies like RabbitMQ or PostgreSQL
require_relative './application'
require 'yaml'

APP_ENV = ENV['APP_ENV'] || 'development'
database_config = YAML.load_file('config/database.yml')[APP_ENV]

ActiveRecord::Base.establish_connection(database_config)
