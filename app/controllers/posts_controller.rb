class PostsController < ApplicationController
	def new
		@post = Post.new
	end
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
	def edit
		@post = Post.find(params[:id])
	end
	def update
		@post = Post.find(params[:id])
		@post.update_attributes(params[:post])
		redirect_to @post
	end
	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to root_url
	end
	def tag
		@posts = Post.all.reverse.select {|p| p.tag == params[:tag]}
	end
end