require 'sinatra/base'
require_relative 'logic'

class PodcastApi < Sinatra::Base

  oauth_id = 'a7f1fe8ba909739c5fc789a8a0211c2c7efe17d89054103fce7d40443b587431'
  oauth_secret = '7654005a9ed92b064d11715350c45474f85abe7e732b8a0daeb8d7eda8d96126'

  client = Audiosearch::Client.new(
  :id     => oauth_id,
  :secret => oauth_secret,
  :host   => 'https://www.audiosear.ch/',
  :debug  => false,
)

  get '/search' do
    res = client.search({ q: 'story', size: 400, from: 0 })
    if !res.is_success
      raise "There was a problem searching: #{res.status} #{res}"
    end
    res.results.each do |episode|
      printf("[%s] %s (%s)\n", episode.id, episode.title, episode.show_title)
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
