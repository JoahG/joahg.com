class PostsController < ApplicationController
	def show
		@post = Post.find(params[:id])
	end
	def index
		@posts = Post.all.reverse
	end
	def create
		@post = Post.new(params[:post])
		if @post.save
			redirect_to root_url
		else
			render "new"
		end
	end
end
