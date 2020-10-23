class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def favorites
    @user = User.find(params[:id])
    @a_favorites = ArtistsFavorite.where(user_id: @user)
    @g_favorites = GalleriesFavorite.where(user_id: @user)
  end

  def show
    if params[:id] == "password"
       redirect_to new_user_session_path
    else
      @user = User.find(params[:id])
    end
  end
  
end
