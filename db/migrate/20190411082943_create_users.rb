class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, :id => false do |t|
      t.primary_key :id, null: false, auto_increment: true, unique: true
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest, null:false
      t.integer :role, default: 2
      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end
end
