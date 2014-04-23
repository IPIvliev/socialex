class Post < ActiveRecord::Base
  attr_accessible :picture, :text, :user_id, :name

  translates :name, :text

  mount_uploader :picture, PictureUploader

  belongs_to :user
end
