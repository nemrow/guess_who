class Friend
	attr_reader :first_name, :last_name, :img_url, :fb_id
	def initialize(params)
		@first_name = params[:first_name]
		@last_name = params[:last_name]
		@img_url = params[:img_url]
		@fb_id = params[:fb_id]
	end
end