class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string     :first_name
      t.string     :last_name
      t.string     :img_url
      t.integer    :fb_id
      t.integer    :board_id

      t.timestamps
    end
  end
end