class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:admin, :gallery_owner, :name, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:admin, :gallery_owner, :name, :avatar, :remove_avatar])
  end

end
