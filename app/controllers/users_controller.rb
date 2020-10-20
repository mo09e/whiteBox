class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def favorites
    @user = User.find(params[:id])
    @a_favorites = ArtistsFavorite.where(user_id: @user)
    @g_favorites = GalleriesFavorite.where(user_id: @user)
  end

  def show
    message_exchange
  end
end
