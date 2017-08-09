# This file is for bootstrapping the application

# Require dependencies
require 'bundler'
Bundler.require
require 'logger'

require 'pathname'
# path to your application root.
APP_ROOT = Pathname.new File.expand_path('../../',  __FILE__)

# Recursively requires all files in ./app and down that end in .rb
Dir.glob(File.join(APP_ROOT, 'app', '**', '*.rb')).each do |source_file|
  puts source_file
  require source_file
end
