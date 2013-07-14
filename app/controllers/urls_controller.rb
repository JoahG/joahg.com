class UrlsController < ApplicationController
	def index
		@urls = Url.all
		@url = Url.new
	end

	def show
		@url = Url.find_by_short(params[:short])
		@url.update_attributes(:clicks => @url.clicks+1)
		redirect_to @url.long
	end

	def new
		@url = Url.new
	end

	def create
		@url = Url.new(params[:url])
		if !Url.find_by_long(@url.long)
			@url.save
		end
		redirect_to root_url
	end

	def info
		@url = Url.find_by_short(params[:short])
	end

	def destroy
		@url = Post.find(params[:id])
		if current_user.admin
			@url.destroy
		end
		redirect_to root_url
	end
end
