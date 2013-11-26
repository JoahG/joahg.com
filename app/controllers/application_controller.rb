class ApplicationController < ActionController::Base
	protect_from_forgery
	
	after_filter :set_access_control_headers
	rescue_from Exception, :with => :error_method

	def set_access_control_headers
		headers['Access-Control-Allow-Origin'] = '*'
		headers['Access-Control-Request-Method'] = '*'
	end

	def error_method
		respond_to do |format|
		    format.html { render :template => "p/fourofour" }
		end
	end
end
