class AddIdToTags < ActiveRecord::Migration
  def change
  	add_column :tags, :tag_id, :string, :null => false, :default => 0
  end
end
