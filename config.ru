require 'rubygems'
require 'bundler/setup'
require File.join(File.dirname(__FILE__), "lib", "holoserve", "server")

run Application.instance.rack
