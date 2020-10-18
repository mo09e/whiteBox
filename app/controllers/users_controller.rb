class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
   def show
     message_exchange
     # if current_user.gallery_owner == true
     #   @gallery = Gallery.find(params[:id])
     # else
     #   @artist = Artist.find(params[:id])
     # end
   end
end
