class Post < ActiveRecord::Base
  attr_accessible :picture, :text, :user_id, :name

  mount_uploader :picture, PictureUploader

  belongs_to :user
end
