class Url < ActiveRecord::Base
  attr_accessible :long, :short, :clicks

  before_create :gen_short

  validates_uniqueness_of :short

  def gen_short
  	c = (0...6).map{ ('a'..'z').to_a[rand(26)] }.join
  	if !Url.find_by_short(c)
  		self.short = c
  	else
  		self.gen_short
  	end
  end
end
