class ApplicationController < ActionController::Base
	protect_from_forgery

	rescue_from Exception, :with => :error_method

  after_filter :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end

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
