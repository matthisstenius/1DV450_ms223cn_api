class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :firstname, :null => false
    	t.string :surname, :null => false
    	t.string :email, :unique => true, :null => false
      t.timestamps
    end
  end
end