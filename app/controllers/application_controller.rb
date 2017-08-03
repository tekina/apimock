class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def run
    request_url = '/' + params[:url]
    params.delete(:url)
    render json: Api.handle(request_url, request.method, params, headers)
  end


end
