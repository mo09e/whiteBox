class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:admin, :gallery_owner, :name, :avatar])
  end

  # def check_if_you_are_already_registered
  #   @artist = Artist.find(params[:id])
  #   @gallery = Gallery.find(params[:id])
  #   if @artist.present? || @gallery.present?
  #     redirect_to root_path,
  #     notice: "既に情報を登録済みです。情報の変更は編集から行ってください。"
  #   end
  # end
end
