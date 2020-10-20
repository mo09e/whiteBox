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
end
