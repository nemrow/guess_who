get '/' do
  @fb_login_link = get_login_link

  if current_user
  	@friends = get_all_friends
  end

  erb :index
end

get '/facebook_auth' do
	user = get_new_access_token(params[:code])
	session[:user_id] = user.id
	redirect to '/'
end

get 'create/game' do 
	erb :game
end

get '/logout' do 
	session[:user_id] = nil
	redirect to '/'
end


