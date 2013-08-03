class SmsController < ApplicationController
  def index
	@twilio_client = Twilio::REST::Client.new "AC110a5ea61b079ecdb05d3fff9c2dd70e", "2a14a64accd4f9b64e8a1500a5b3ab04"
    body = params["Body"]
    num = params["From"]
    bo_sp = body.split
    msg = ""

 	if bo_sp.length == 2
 		if num == "+14097281957"
	 		if bo_sp[0] == "DELETE" and bo_sp[1].length == 6
	 			@url = Url.find_by_short(bo_sp[1])
	 			if @url
		 			@url.destroy
		 			msg = "Deleted Short URL."
				else
					msg = "URL does not exist."
				end
	 		else
	 			msg = "Invalid Command"
			end
		else
			msg = "Invalid Permissions"
		end
	end

	if bo_sp.length == 1
		@url = Url.new
		@url.long = bo_sp[0]

		if @url.long[-1,1] == "/"
			@url.long = @url.long[0..@url.long.length-2]
		end

		if !Url.find_by_long(@url.long) and !Url.find_by_long(@url.long+"/")
		    if !@url.save
		        msg = "error"
		    end
		else
			@url = Url.find_by_long(@url.long)
		end

		if num != "+14097281957"
			@twilio_client.account.sms.messages.create(
		      :from => "+14093324635",
		      :to => "+14097281957",
		      :body => "Short url created via SMS for #{@url.long}: http://go.joahg.com/#{@url.short}"
		    )
		end

		if msg != "error"
			msg = "http://go.joahg.com/"+@url.short
		end
	end

	if msg == ""
		msg = "Something went wrong :("
	end

	@twilio_client.account.sms.messages.create(
	  :from => "+14093324635",
	  :to => num,
	  :body => msg
	)
  end
end