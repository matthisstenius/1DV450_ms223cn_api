require "#{Rails.root}/app/TOERH/APIAuth"
require "#{Rails.root}/app/TOERH/UserAuth"

class ApplicationController < ActionController::Base
  before_filter :cors_preflight_check
  #after_filter :cors_set_access_control_headers

  def options
    render :text => '', :content_type => 'text/plain'
  end

  def require_login
  	if session[:admin].nil?
  		redirect_to showLogin_path
  	end
  end

  def api_access_granted
    begin
      apiAuth = TOERH::APIAuth.new
      apiAuth.api_access(request.headers['X-Api-Token'])
    rescue Exception => e
  		errorResponse = [status: 401, message: 'The API-key is not valid. Please check that the key exist and is valid.']

  		response.status = 401
  		
  		respond_to do |format|
  			format.xml { render xml: errorResponse}
  			format.json {render json: errorResponse}
  		end
  	end
  end

  def authorize
    access_token = request.authorization()
    user = User.where(access_token: access_token).take

    if user
      unless user.user_id == params[:user_id] || params[:id]
        not_authorized()
      else
        if user.access_token_expire < Time.now
          access_token_expired()
        end
      end
    else
      not_authorized()
    end
  end

  def handle_exception(exception)
    case exception
    when ActiveRecord::RecordNotFound
      not_found(exception)
    when ActiveRecord::RecordInvalid
      invalid_record_error(exception.record.errors)
    when Exception 
      internal_server_error
    end
  end

  def not_found(exception)
    response.status = 404
                
    errorResponse = {status: 404, message: "The requested item/items could not be found. Please check the ID/ID's and try again"}

    respond_to do |format|
      format.xml { render xml: errorResponse}
      format.json {render json: errorResponse}
    end
  end

  def invalid_record_error(errors)
    response.status = 400

    errorResponse = {status: 400, message: 'There are errors in the request. Please correct the errors and try again', 
      errors: errors}

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

  def not_authorized
    response.status = 401

    errorResponse = {
      status: 401, 
      message: "Unauthorized request.", 
      links: {
        authenticate: "http://#{request.host}/api/v1/authenticate",
        documentation: "http://#{request.host}/docs?autehnticate"
      }
    }

    respond_to do |format|
      format.xml { render xml: errorResponse}
      format.json {render json: errorResponse}
    end
  end

  def access_token_expired
    response.status = 401

    errorResponse = {
      status: 401, 
      message: "The access_token has expired", 
      links: {
        authenticate: "http://#{request.host}/api/v1/authenticate",
        documentation: "http://#{request.host}/docs?autehnticate"
      }
    }

    respond_to do |format|
      format.xml { render xml: errorResponse}
      format.json {render json: errorResponse}
    end
  end

  private 

  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, DELETE, PATCH, HEAD'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Authorization, X-Api-Token, Content-Type, Origin, Accept'
    headers['Access-Control-Max-Age'] = '86400'
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    # headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, DELETE'
    # headers['Access-Control-Max-Age'] = "1728000"
  end
end
