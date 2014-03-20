class AddIdToResourceTypes < ActiveRecord::Migration
  def change
  	add_column :resource_types, :resource_type_id, :string, :null => false, :default => 0
  end
end
