class GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:edit, :destroy, :update, :new]

  def index
    @search = Gallery.ransack(params[:q])
    @galleries = @search.result
  end

  def new
    if current_user.gallery_owner != true
      redirect_to artists_path,
      notice: "あなたは作家なのでギャラリー情報は登録できません"
    end
    if params[:back]
      @gallery = Gallery.new(gallery_params)
    else
      @gallery = Gallery.new
    end
  end

  def create
    @gallery = current_user.build_gallery(gallery_params)
    if params[:back]
      render :new
    else
      if @gallery.save
        redirect_to galleries_path, notice: "ギャラリー情報を登録しました"
      else
        render :new
      end
    end
  end

  def show
    @reservation = @gallery.reservations.all
    message_exchange
    @favorite = current_user.galleries_favorites.find_by(gallery_id: @gallery.id)
  end

  def edit
  end

  def update
    if @gallery.update(gallery_params)
      redirect_to gallery_path(@gallery), notice: "編集しました"
    else
      render :edit
    end
  end

  def gallery_params
    params.require(:gallery).permit(:name, :note, :phone_number, :url, :address, :rental_fee, :lending_period,
                                    { images: []}, :images_cache, :layout, :layout_cache, { label_ids: [] })
                                   .merge(user_id: current_user.id)
  end

  def set_gallery
    @gallery = Gallery.find(params[:id])
  end
end
