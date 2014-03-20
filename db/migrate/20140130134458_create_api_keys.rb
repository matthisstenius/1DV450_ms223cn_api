class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
    	t.string 'apiKey', :unique, null: false
    	t.string 'email', :unique, null: false
      	t.timestamps
    end
  end
end
