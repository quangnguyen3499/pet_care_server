class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include BaseApi
  include Response

  rescue_from CanCan::AccessDenied do |exception|
    json_response :forbidden, {}, exception
  end

  def render_authenticate_error
    raise ApiError::Authenticate
  end

  private

  def check_auth_upload
    current_user = current_api_v1_company_admin || current_api_v1_client
    render_authenticate_error unless current_user
  end

  def current_ability
    @current_ability ||= Ability.new(current_auth_resource, params)
  end

  def current_auth_resource
    if api_v1_company_admin_signed_in?
      current_api_v1_company_admin
    elsif api_v1_client_signed_in?
      current_api_v1_client
    end
  end
end
