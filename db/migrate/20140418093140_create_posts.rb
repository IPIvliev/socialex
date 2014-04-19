class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :user_id
      t.string :picture
      t.string :text
      t.string :name

      t.timestamps
    end
  end
end
