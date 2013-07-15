class UrlsController < ApplicationController
	def index
		@urls = Url.all
		@url = Url.new
	end

	def show
		@url = Url.find_by_short(params[:short])
		@url.update_attributes(:clicks => @url.clicks+1)
		respond_to do |format|
			format.html { redirect_to @url.long }
			format.json { render :json => @url.to_json }
		end
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

	def api_create      
	    @url = Url.new
	    @url.long = params[:long]
	    if !Url.find_by_long(@url.long)
		    if !@url.save
		        @url = "error"
		    end
		else
			@url = Url.find_by_long(@url.long)
		end
	    render json: @url
	end

	def info
		@url = Url.find_by_short(params[:short])
	end

	def login
	end

	def destroy
		@url = Url.find(params[:id])
		if current_user && current_user.admin?
			@url.destroy
		end
		redirect_to root_url
	end
end
