# localhost:5678/other.html

require_relative 'response'

class ResponseBuilder
  def build_response(request:)
    if request[:path] == '/'
      respond_with('views' + '/index.html')
    else
      respond_with('views' + request[:path])
    end
  end

  def respond_with(path_to_file)
    Response.new(
      code: 200,
      data: File.binread(path_to_file)
    )
    Responce.new(
    	code: 404,
    	raise ActionController::RoutingError.new('Not Found')
    )

  end
end
