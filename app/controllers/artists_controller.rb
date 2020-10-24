class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:edit, :destroy, :update, :new]

  def index
    @artists = Artist.all
    @artists = @artists.page(params[:page]).per(7)
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
    if user_signed_in?
      @current_user_entry = Entry.where(user_id: current_user.id)
      @user_entry = Entry.where(user_id: @artist.user_id)
      if @artist.user_id == current_user.id
         @current_user_entry
      else
        @current_user_entry.each do |current_user_e|
          @user_entry.each do |user_e|
            if current_user_e.room_id == user_e.room_id then
              @is_room = true
              @room_id = current_user_e.room_id
            end
          end
        end
        unless @is_room
          @room = Room.new
          @entry = Entry.new
        end
      end
      @favorite = current_user.artists_favorites.find_by(artist_id: @artist.id)
    end
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

  def destroy
    @artist.destroy
    redirect_to artists_path, notice: "Deleted"
  end

  def artist_params
    params.require(:artist).permit(:name, :note, :phone_number, { images: []}, :url, :images_cache)
                                   .merge(user_id: current_user.id)
  end

  def set_artist
    @artist = Artist.find(params[:id])
  end
end
