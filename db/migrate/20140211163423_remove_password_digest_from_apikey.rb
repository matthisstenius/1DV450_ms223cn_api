class RemovePasswordDigestFromApikey < ActiveRecord::Migration
  def change
  	remove_column :api_keys, :password_digest
  end
end
