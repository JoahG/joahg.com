class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  attr_accessible :content, :tag, :title, :user_id, :preview
  belongs_to :user

  def rendered	
    require 'redcarpet'
    redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new, {fenced_code_blocks: true})
    return redcarpet.render self.content
  end
end
