class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session

  def require_login
  	if session[:admin].nil?
  		redirect_to showLogin_path
  	end
  end

  def api_access_granted
    token = request.authorization()
    
  	unless ApiKey.exists?(api_key: token)
  		errorResponse = [status: 401, message: 'The request is not authorized. Please check that the Authorization header is included in the request.']

  		response.status = 401
  		
  		respond_to do |format|
  			format.xml { render xml: errorResponse}
  			format.json {render json: errorResponse}
  		end
  	end
  end

  def handle_exception(exception)
    case exception
    when ActiveRecord::RecordNotFound
      not_found
    # else 
    #   internal_server_error
    end
  end

  def not_found
    response.status = 404
    errorResponse = {status: 404, message: "The requested resource with ID could not be found"}

    respond_to do |format|
      format.xml { render xml: errorResponse}
      format.json {render json: errorResponse}
    end
  end

  def internal_server_error
    response.status = 500
    errorResponse = {status: 500, message: "Opps. Something unexcpected happend. The request could not be handled. Please try again later."}

    respond_to do |format|
      format.xml { render xml: errorResponse}
      format.json {render json: errorResponse}
    end
  end
end
