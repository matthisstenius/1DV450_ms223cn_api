class RenameAppTokenColumn < ActiveRecord::Migration
  def change
  	rename_column :api_keys, :appToken, :api_key
  end
end
