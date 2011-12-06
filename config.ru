require 'rubygems'
require 'bundler/setup'

require File.join(File.dirname(__FILE__), "lib", "application")

application = Application.new
run application.rack
