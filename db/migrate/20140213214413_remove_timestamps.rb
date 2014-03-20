class RemoveTimestamps < ActiveRecord::Migration
  def change
  	remove_column :tags, :created_at
  	remove_column :tags, :updated_at

  	remove_column :licences, :created_at
  	remove_column :licences, :updated_at

  	remove_column :resource_types, :created_at
  	remove_column :resource_types, :updated_at
  end
end
