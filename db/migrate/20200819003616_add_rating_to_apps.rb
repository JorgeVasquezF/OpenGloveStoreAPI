class AddRatingToApps < ActiveRecord::Migration[5.2]
  def change
    add_column :apps, :rating, :string
  end
end
