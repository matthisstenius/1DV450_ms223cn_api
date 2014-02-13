class CreateResoucesTags < ActiveRecord::Migration
  def change
    create_table :resources_tags, :id => false do |t|
    	t.belongs_to :resource, :null => false
    	t.belongs_to :tag, :null => false
    	t.timestamps
    end

    add_index :resources_tags, [:resource_id, :tag_id]
  end
end
