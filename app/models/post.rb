class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  serialize :tags, Array

  attr_accessible :content, :tags, :title, :user_id
  belongs_to :user

  def preview
  	if self.rendered.length > 400
  		self.rendered.slice(0,397)+"..."
  	else
  		self.content
  	end
  end

  def rendered	
	require 'redcarpet'
	redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new, {fenced_code_blocks: true})
	return redcarpet.render self.content
  end
end
