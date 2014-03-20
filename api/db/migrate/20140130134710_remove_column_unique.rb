class RemoveColumnUnique < ActiveRecord::Migration
  def change
  	remove_column :api_keys, 'unique'
  end
end
