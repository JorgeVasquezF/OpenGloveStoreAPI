class CreateApps < ActiveRecord::Migration[5.2]
  def change
    create_table :apps, :id => false do |t|
      t.primary_key :id, null: false, auto_increment: true, unique: true
      t.string :name
      t.string :description
      t.string :git_url
      t.string :video_url
      t.string :documentation
      t.boolean :published, default: false
      t.string :image_url
      t.integer :verified, default: 0
      t.string :last_release
      t.string :os
      t.timestamps
    end    
  end
end
