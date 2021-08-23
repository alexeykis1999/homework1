class ApplicationController < ActionController::Base
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
rescue_from ActionController::RoutingError, with: :routing_error

     def route_not_found
    	render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
  	end
 
 
  private
    def record_not_found
    	flash[:error] = "You don't have access to this section."
      render plain: "404 Not Found", status: 404
    end
    

  
   # def routing_error
    #	flash[:error] = "You don't have access to this section."
     # render plain: "404 Not Found", status: 500
    #end
end
