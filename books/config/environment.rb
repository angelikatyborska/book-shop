# This file is for initialization of dependencies like RabbitMQ or PostgreSQL
require_relative './application'
require 'yaml'
require 'erb'

ActiveRecord::Base.logger = Logger.new(STDOUT) # FIXME: share the logger between the database, bunny and the app
ActiveRecord::Base.establish_connection(Books.database_config)
