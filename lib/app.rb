require 'sinatra/base'
require_relative 'logic'
require 'json'
require 'sinatra/cross_origin'





class PodcastApi < Sinatra::Base

    register Sinatra::CrossOrigin

    configure do
      enable :cross_origin
    end

    options "*" do
    response.headers["Allow"] = "HEAD,GET,PUT,DELETE,OPTIONS"

    # Needed for AngularJS
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"

    halt HTTP_STATUS_OK
  end

  client = Audiosearch::Client.new(
  :id     => ENV['OAUTH_ID'],
  :secret => ENV['OAUTH_SECRET'],
  :host   => 'https://www.audiosear.ch/',
  :debug  => false,
)

  get '/search' do
  res = client.get('/search/episodes/*?'+ params[:search_term] +'&size=200&from=0')
    if !res.is_success
      raise "There was a problem searching: #{res.status} #{res}"
    end
    res.results.to_json
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
