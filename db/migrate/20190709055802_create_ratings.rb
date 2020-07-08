class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings, :id => false do |t|
      t.primary_key :id, null: false, auto_increment: true, unique: true
      t.float :rating
      t.string :ip
      t.string :comment
      t.date :date
      t.belongs_to :app, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
