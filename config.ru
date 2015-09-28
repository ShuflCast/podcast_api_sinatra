require 'rubygems'
require File.join(File.dirname(__FILE__), 'lib/app.rb')
register Sinatra::CrossOrigin
run PodcastApi
