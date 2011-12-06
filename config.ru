require 'rubygems'
require 'bundler/setup'

require File.join(File.dirname(__FILE__), "lib", "application")

run Application.instance.rack
