# This file is for initialization of dependencies like RabbitMQ or PostgreSQL
require_relative './application'
require 'yaml'
require 'erb'

ActiveRecord::Base.establish_connection(Books.database_config)
