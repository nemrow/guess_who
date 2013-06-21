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

get '/create/game' do 
  if current_user
    @my_friends = get_all_friends.sample(25)
  end
  p @my_friends
	erb :game
end

get '/logout' do 
	session[:user_id] = nil
	redirect to '/'
end

get '/game' do 
	erb :game
end


get '/get_board' do 
  board = Board.create

p board.id

  content_type "json"

  board.id.to_json
end


