class CreatePostTranslations < ActiveRecord::Migration
  def up
  	Post.create_translation_table! :name => :string, :text => :text
  end

  def down
  	Post.drop_translation_table!
  end
end
