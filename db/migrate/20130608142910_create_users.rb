class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :first_name
      t.string :last_name
  		t.string :email
  		t.integer :fb_id
  		t.string :fb_access_token

  		t.timestamps
  	end
  end
end
