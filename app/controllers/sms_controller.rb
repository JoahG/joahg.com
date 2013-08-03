class SmsController < ApplicationController
  def index
	@twilio_client = Twilio::REST::Client.new "AC110a5ea61b079ecdb05d3fff9c2dd70e", "2a14a64accd4f9b64e8a1500a5b3ab04"
    body = params["Body"]
    num = params["From"]
 	if num == "+14097281957"
 		bo_sp = body.split
 		if bo_sp.length == 2 and bo_sp[0] == "DELETE" and bo_sp[1].length == 6
 			@url = Url.find_by_short(bo_sp[1])
 			@url.destroy
 		else
 			@twilio_client.account.sms.messages.create(
			  :from => "+14093324635",
			  :to => num,
			  :body => "Invalid Command"
			)
		end
	else
		@twilio_client.account.sms.messages.create(
		  :from => "+14093324635",
		  :to => num,
		  :body => "Invalid Number"
		)
	end
  end
end