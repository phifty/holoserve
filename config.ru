require 'rubygems'
require 'bundler/setup'
require File.join(File.dirname(__FILE__), "holoserve")

run Application.instance.rack
