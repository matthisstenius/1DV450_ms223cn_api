class AddIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :user_id, :string, :null => false, :default => 0
  end
end
