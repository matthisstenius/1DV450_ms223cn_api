class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
		t.string :name, 			:null => false
    	t.string :description,  	:null => false
    	t.string :url, 				:null => false
    	t.belongs_to :user, 		:null => false
    	t.belongs_to :resource_type, :null => false
    	t.belongs_to :licence, 		:null => false
      	t.timestamps
    end
  end
end
