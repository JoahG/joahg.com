class PController < ApplicationController
	def index
		if request.headers['X-PJAX']
	        render :layout => false
	    end
	end

	def find
		if request.headers['X-PJAX']
	        render :layout => false
	    end
	end

	def about
		if request.headers['X-PJAX']
	        render :layout => false
	    end
	end
end
