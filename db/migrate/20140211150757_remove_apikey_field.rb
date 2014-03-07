class RemoveApikeyField < ActiveRecord::Migration
  def change
  	remove_column :api_keys, :apiKey
  end
end
