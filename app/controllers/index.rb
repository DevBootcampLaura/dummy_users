enable :sessions
# use Rack::Session::Cookie

get '/' do
  # Look in app/views/index.erb
  p session[:id]
  erb :index
end

post '/' do
  @user = User.find_by(email: params[:email])
  if @user == nil
    "We could not locate a user based upon the email you provided."
  elsif @user.password == params[:password]
    session[:id] = @user.id
    p session[:id]
    erb :secret_page
  else
    "The password you provided is incorrect. Please try again or create an account."
  end
end

get '/secret' do
  if session[:id] == nil
    redirect to('/')
  else
    erb :secret_page
  end
end

get '/logout' do
  session.clear
  p session[:id]
  redirect to('/')
end

get '/sign_up' do
  erb :sign_up
end

post '/sign_up' do
  @u = User.create(name: params[:name], email: params[:email], password: params[:password])
  session[:id] = @u.id
  p session[:id]
  erb :secret_page
end
