class AddIdToResource < ActiveRecord::Migration
  def change
  	add_column :resources, :resource_id, :string, :null => false, :default => 0
  end
end
