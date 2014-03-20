class CreateAdmin < ActiveRecord::Migration
  def change
    create_table :admins do |t|
    	t.string :email, :null => false, :unique => true
    	t.string :password_digest
    	t.timestamps
    end
  end
end
