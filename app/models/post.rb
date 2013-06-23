class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  serialize :tags, Array

  attr_accessible :content, :tags, :title, :user_id
  belongs_to :user

  def preview
  	if self.content.length > 400
  		self.content.slice(0,397)+"..."
  	else
  		self.content
  	end
  end
end
