class AddPasswordDogestToApikeyTable < ActiveRecord::Migration
  def change
  	change_table :api_keys do |t|
  		t.string :password_digest
  	end
  end
end
