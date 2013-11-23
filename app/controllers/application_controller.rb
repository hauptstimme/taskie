class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!, unless: :api_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :user_timezone, if: ->{ signed_in? && current_user.time_zone.present? }

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:accept_invitation) { |u| u.permit(:username, :password, :password_confirmation, :invitation_token) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :password, :remember_me) }
  end

  def user_timezone(&block)
    Time.use_zone current_user.time_zone, &block
  end

  def api_controller?
    false
  end
end
