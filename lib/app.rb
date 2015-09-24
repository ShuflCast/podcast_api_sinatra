require 'sinatra/base'
require 'audiosearch'

class PodcastApi < Sinatra::Base

  callback = 'urn:ietf:wg:oauth:2.0:oob'
  oauth_id = '475c328ee18addadc17e6d209b50f621294dc407f029066dfc48627807efb215'
  oauth_secret = '6674d12de429eb0847260976661fca23325442a611f82b3343e1c0ebc8d49bcf'
  auth_code = '825041365880b4fb245c9ba5a53e3101084c9c9568d687d05fd831984986a216'
  url = 'https://www.audiosear.ch/api/search/episodes/filters[categories.name_lc]='

  client = Audiosearch::Client.new(
  :id     => '475c328ee18addadc17e6d209b50f621294dc407f029066dfc48627807efb215',
  :secret => '6674d12de429eb0847260976661fca23325442a611f82b3343e1c0ebc8d49bcf',
  :host   => 'https://www.audiosear.ch/',
  :debug  => false,
)

  get '/search' do
    # search_term = params[:search_term]
    # response = client.search({q: 'test'}, 'episodes')
    show = client.get('/shows/1')
    p show
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
