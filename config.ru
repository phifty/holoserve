require 'rubygems'
require 'bundler/setup'
require File.join(File.dirname(__FILE__), "lib", "holoserve")

run Holoserve.instance.rack
