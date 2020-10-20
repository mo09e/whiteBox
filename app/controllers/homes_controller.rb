class HomesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def index
    @users = User.all
    @artists = Artist.limit(5).order('id DESC')
    @galleries = Gallery.limit(5).order('id DESC')
  end

  def show
    @user = User.find(params[:id])
  end
end
