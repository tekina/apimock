class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def run
    request_url = '/' + params[:url]
    params.delete(:url)
    resp, status = Api.handle(request_url, request.method, params, headers)
    render json: resp, status: status
  end


end
