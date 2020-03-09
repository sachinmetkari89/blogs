class ApplicationController < ActionController::Base
  PER_PAGE = 10
    
    rescue_from ActiveRecord::DeleteRestrictionError do |exception|
		redirect_back fallback_location: request.referer
        flash[:errors] = exception.message.humanize
	end

end
