class AddAppToken < ActiveRecord::Migration
  def change
  	change_table :api_keys do |t|
  		t.string :appToken
  	end
  end
end
