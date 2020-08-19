class RenameRatingToRatingApp < ActiveRecord::Migration[5.2]
  def change
    rename_column :apps, :rating, :rating_app
  end
end
