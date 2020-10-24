class HomesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def index
    @users = User.all
    @artists = Artist.limit(5).order('id DESC').includes(:user)
    @galleries = Gallery.limit(5).order('id DESC').includes(:user, :label)
  end

  def show
    @user = User.find(params[:id])
  end
end
