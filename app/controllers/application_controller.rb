class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:admin, :gallery_owner, :name, :avatar])
  end

  def message_exchange
    @user = User.find(params[:id])
    @current_user_entry  = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
       @current_user_entry
    else
      @current_user_entry .each do |current_user_e|
        @user_entry.each do |user_e|
          if current_user_e.room_id == user_e.room_id then
            @is_room = true
            @room_id = current_user_e.room_id
          end
        end
      end
      if @is_room
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
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
