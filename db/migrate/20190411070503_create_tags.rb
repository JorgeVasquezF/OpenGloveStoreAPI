class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags, :id => false do |t|
      t.primary_key :id, null: false, auto_increment: true, unique: true
      t.string :name

      t.timestamps
    end
  end
end
