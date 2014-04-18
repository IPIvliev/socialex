class Post < ActiveRecord::Base
  attr_accessible :picture, :text, :user_id

  belongs_to user
end
