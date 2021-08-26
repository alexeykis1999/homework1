class ApplicationController < ActionController::Base
	before_action :set_locale
	
 
 
  private
    def record_not_found
    	flash[:error] = "You don't have access to this section."
      render plain: "404 Not Found", status: 404
    end
    
		def default_url_options
			{locale: I18n.locale}
		end

		def set_locale
			I18n.locale = extract_locale || I18n.default_locale
		end	

		def extract_locale
			parsed_locale = params[:locale]
			I18n.available_locales.map(&:to_s).include?(parsed_locale) ?
				parsed_locale.to_sym :
				nil
		end
  
   # def routing_error
    #	flash[:error] = "You don't have access to this section."
     # render plain: "404 Not Found", status: 500
    #end
end
