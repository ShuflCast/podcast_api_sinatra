require 'sinatra/base'
require_relative 'logic'
require 'json'

class PodcastApi < Sinatra::Base

  client = Audiosearch::Client.new(
  :id     => ENV['OAUTH_ID'],
  :secret => ENV['OAUTH_SECRET'],
  :host   => 'https://www.audiosear.ch/',
  :debug  => false,
)

  get '/search' do
  res = client.get('/search/episodes/*?'+ params[:search_term] +'&size=100&from=0')
    if !res.is_success
      raise "There was a problem searching: #{res.status} #{res}"
    end
    res.results.to_json
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
