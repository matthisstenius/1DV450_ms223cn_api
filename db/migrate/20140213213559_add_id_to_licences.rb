class AddIdToLicences < ActiveRecord::Migration
  def change
  	add_column :licences, :licence_id, :string, :null => false, :default => 0
  end
end
