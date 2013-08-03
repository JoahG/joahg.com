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

		if @url.long[-1,1] == "/"
			@url.long = @url.long[0..@url.long.length-2]
		end

		if !Url.find_by_long(@url.long) and !Url.find_by_long(@url.long+"/")
			@url.save
		else
			@url = Url.find_by_long(@url.long)
		end


		@twilio_client = Twilio::REST::Client.new "AC110a5ea61b079ecdb05d3fff9c2dd70e", "2a14a64accd4f9b64e8a1500a5b3ab04"
	 
	    @twilio_client.account.sms.messages.create(
	      :from => "+14093324635",
	      :to => "+14097281957",
	      :body => "Short url created for #{@url.long}: http://go.joahg.com/#{@url.short}"
	    )


		redirect_to info_url_path(@url.short)
	end

	def api_create      
	    @url = Url.new
	    @url.long = params[:long]

		if @url.long[-1,1] == "/"
			@url.long = @url.long[0..@url.long.length-2]
		end

	    if !Url.find_by_long(@url.long) and !Url.find_by_long(@url.long+"/")
		    if !@url.save
		        @url = "error"
		    end
		else
			@url = Url.find_by_long(@url.long)
		end

		@twilio_client = Twilio::REST::Client.new "AC110a5ea61b079ecdb05d3fff9c2dd70e", "2a14a64accd4f9b64e8a1500a5b3ab04"
	 
	    @twilio_client.account.sms.messages.create(
	      :from => "+14093324635",
	      :to => "+14097281957",
	      :body => "Short url created for #{@url.long}: http://go.joahg.com/#{@url.short}"
	    )

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
