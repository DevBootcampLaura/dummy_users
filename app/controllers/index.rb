enable :sessions
# use Rack::Session::Cookie

get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/sign_in' do
  @user = User.authenticate(params[:email], params[:password])
  redirect to('/') if @user == nil

  session[:id] = @user.id
  redirect to('/secret')
end

get '/secret' do
  redirect to('/') if session[:id] == nil

  erb :secret_page
end

get '/logout' do
  session.clear
  redirect to('/')
end

get '/sign_up' do
  erb :sign_up
end

post '/sign_up' do
  @u = User.create!(name: params[:name], email: params[:email], password: params[:password])
  session[:id] = @u.id
  redirect to('/secret')
end
