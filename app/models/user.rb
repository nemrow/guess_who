class User < ActiveRecord::Base
  belongs_to :board
  has_one :mystery_friend, through: :board, source: :friends
end
