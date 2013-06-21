def get_new_access_token(connection_code)
	facebook_response = CGI::parse(open("https://graph.facebook.com/oauth/access_token?client_id=#{FACEBOOK_APP_ID}&redirect_uri=http://localhost:9393/facebook_auth&client_secret=#{FACEBOOK_SECRET}&code=#{connection_code}").read)
	access_token = facebook_response["access_token"][0]
	@token_expiration_date = facebook_response["expires"][0]
	fb_user = JSON.parse(open("https://graph.facebook.com/me?fields=first_name,last_name,email&access_token=#{access_token}").read)
	# parse out each param you requested here:
	first_name = fb_user["first_name"]
	last_name = fb_user["last_name"]
	fb_id = fb_user["id"]
	email = fb_user["email"]
	user = User.find_or_create_by_email(email)
	# add/update user in database here:
	user.update_attributes(	
													:first_name => first_name,
													:last_name => last_name, 
													:email => email, 
													:fb_id => fb_id, 
													:fb_access_token => access_token
												)
	user.save
	user
end

# enter all params you want to obtain from user
# separate by commas, no spaces, no comma after last param
# ex: fb_params_list = "name,email,user_photos"
# full list of possible params at:
# https://developers.facebook.com/docs/reference/api/user/

def get_fb_params
	"user_photos,email"
end

def get_login_link
	"https://graph.facebook.com/oauth/authorize?client_id=#{FACEBOOK_APP_ID}&redirect_uri=http://localhost:9393/facebook_auth&scope=#{get_fb_params}"
end

def get_all_friends
friends_array = []
friends = facebook_request("friends?fields=first_name,last_name")
friends["data"].each do |friend|
	friends_array << Friend.new(
															:first_name => friend["first_name"], 
															:last_name => friend["last_name"],
															:img_url => get_facebook_user_img(friend["id"]),
															:fb_id => friend["id"]
															)
	end
	friends_array
end

def facebook_request(params)
	fb_user = JSON.parse(open("https://graph.facebook.com/me/#{params}&access_token=#{fb_access_token}").read)
end

def get_facebook_user_img(id)
	"https://graph.facebook.com/#{id}/picture"
end

def fb_access_token
	current_user.fb_access_token
end



