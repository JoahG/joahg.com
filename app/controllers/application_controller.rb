class ApplicationController < ActionController::Base
	protect_from_forgery

	rescue_from Exception, :with => :error_method

	private

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def error_method
		respond_to do |format|
		    format.html { render :template => "p/fourofour" }
		end
	end

	helper_method :current_user
end
