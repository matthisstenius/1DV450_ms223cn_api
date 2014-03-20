class AddAccesstokenExpireToUsersTable < ActiveRecord::Migration
  def change
  	add_column :users, :access_token_expire, :datetime
  end
end
