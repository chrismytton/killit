require 'sinatra'
require 'json'
require 'open-uri'
require 'uri'

helpers do
  def get_image_for(thing)
    body = JSON.parse(open("http://ajax.googleapis.com/ajax/services/search/images?v=1.0&rsz=8&safe=active&q=#{URI.escape thing}").read)
    images = body['responseData']['results']
    image  = images[ rand * images.length ]
    image['unescapedUrl']
  end
end

get '/' do
  erb :index
end

post '/' do
  redirect to("/kill/#{params[:target]}/with/#{params[:weapon]}")
end

get '/kill/:target/with/:weapon' do |target, weapon|
  @target = get_image_for target
  @weapon = get_image_for weapon
  erb :kill
end

run Sinatra::Application
