class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:edit, :destroy, :update, :new]

  def index
    @artists = Artist.all
  end

  def new
    if current_user.gallery_owner == true
      redirect_to galleries_path,
      notice: "あなたはギャラリー所有者なので作家情報は登録できません"
    end
    if params[:back]
      @artist = Artist.new(artist_params)
    else
      @artist = Artist.new
    end
  end

  def create
    @artist = current_user.build_artist(artist_params)
    if params[:back]
      render :new
    else
      if @artist.save
        redirect_to artists_path, notice: "作家情報を登録しました"
      else
        render :new
      end
    end
  end

  def show
    message_exchange
    @favorite = current_user.artists_favorites.find_by(artist_id: @artist.user_id)
  end

  def edit
  end

  def update
    if @artist.update(artist_params)
      redirect_to artist_path(@artist), notice: "編集しました"
    else
      render :edit
    end
  end

  def artist_params
    params.require(:artist).permit(:name, :note, :phone_number, { images: []}, :url, :images_cache)
                                   .merge(user_id: current_user.id)
  end

  def set_artist
    @artist = Artist.find(params[:id])
  end
end
