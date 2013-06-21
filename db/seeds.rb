require 'faker'

User.delete_all
Friend.delete_all
Board.delete_all

# Create 200 users
def create_user
  id = (1..100).to_a.sample
  user = User.create( :first_name        => Faker::Name.first_name,
                      :last_name         => Faker::Name.last_name,
                      :email             => Faker::Internet.email,
                      :fb_id             => id,
                      :fb_access_token   => "password" )
  return user
end

# Create 200 friends
def create_friend
  id = (101..1000).to_a.sample
  friend = Friend.create( :first_name => Faker::Name.first_name,
                          :last_name  => Faker::Name.last_name,
                          :img_url    => get_facebook_user_img(id),
                          :fb_id      => id )
  return friend
end

# Create 50 boards
50.times do
  board = Board.new
    2.times do
      board.users << create_user
      13.times do
        board.friends << create_friend
      end
    end
    board.save
end

