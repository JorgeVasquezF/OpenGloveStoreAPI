class CreateChecks < ActiveRecord::Migration[5.2]
  def change
    create_table :checks do |t|
      t.belongs_to :user, index: true
      t.belongs_to :app, index: true
      t.integer :role
      t.boolean :approved, default: false
      t.boolean :disapproved, default: false
      t.string :comment
      t.timestamps
    end
  end
end
