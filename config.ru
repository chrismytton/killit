%w{sinatra json open-uri uri}.each { |lib| require lib }

helpers do
  def get_image_for(thing)
    body = JSON.parse(open("http://ajax.googleapis.com/ajax/services/search/images?v=1.0&rsz=8&safe=active&q=#{URI.escape thing}").read)
    images = body['responseData']['results']
    image  = images[ rand * images.length ]
    image['unescapedUrl']
  end
  def current_target; params[:target] || 'x' end
  def current_weapon; params[:weapon] || 'y' end
end

get '/' do
  erb :index
end

post '/' do
  redirect to("/kill/#{params[:target]}/with/#{params[:weapon]}")
end

get '/kill/:target/with/:weapon' do
  @target = get_image_for current_target
  @weapon = get_image_for current_weapon
  erb :kill
end

run Sinatra::Application
