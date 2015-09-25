require 'sinatra/base'
require_relative 'logic'

class PodcastApi < Sinatra::Base

  client = Audiosearch::Client.new(
  :id     => ENV['OAUTH_ID'],
  :secret => ENV['OAUTH_SECRET'],
  :host   => 'https://www.audiosear.ch/',
  :debug  => false,
)

  get '/search' do
    res = client.search({ q: 'story', size: 400, from: 0 })
    if !res.is_success
      raise "There was a problem searching: #{res.status} #{res}"
    end
    res.results
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
