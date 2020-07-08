class CreateJoinTableAppTag < ActiveRecord::Migration[5.2]
  def change
    create_join_table :apps, :tags do |t|
      t.index [:app_id, :tag_id]
      t.index [:tag_id, :app_id]
    end
  end
end
