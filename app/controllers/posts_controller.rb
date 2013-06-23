class PostsController < ApplicationController
	def show
		@post = Post.find(params[:id])
	end
	def index
		@posts = Post.all.reverse
	end
	def create
		@post = Post.new(params[:post])
		@post.save
		redirect_to @post
	end
end
