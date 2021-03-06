class GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:edit, :destroy, :update, :new]

  def index
    @q = Gallery.ransack(params[:q])
    @galleries = @q.result.includes(:user, :label)
    @galleries = @galleries.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
    @galleries = @galleries.order(created_at: :desc).page(params[:page]).per(7)
  end

  def new
    if current_user.gallery_owner != true
      redirect_to artists_path,
      notice: t('view.msg.can_not_register_gallery_information')
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
        redirect_to galleries_path, notice: t('activerecord.attributes.gallery.create')
      else
        render :new
      end
    end
  end

  def show
    @reservation = @gallery.reservations.all
    if user_signed_in?
      @current_user_entry = Entry.where(user_id: current_user.id)
      @user_entry = Entry.where(user_id: @gallery.user_id)
      if @gallery.user_id == current_user.id
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

      @favorite = current_user.galleries_favorites.find_by(gallery_id: @gallery.id)
    end
  end

  def edit
  end

  def update
    if @gallery.update(gallery_params)
      redirect_to gallery_path(@gallery), notice: t('activerecord.attributes.gallery.edit')
    else
      render :edit
    end
  end

  def destroy
    @gallery.destroy
    redirect_to root_path, notice: "Deleted"
  end

  private
  def gallery_params
    params.require(:gallery).permit(:name, :note, :phone_number, :url, :address, :rental_fee, :lending_period,
                                    { images: []}, :images_cache, :layout, :layout_cache, { label_ids: [] })
                                   .merge(user_id: current_user.id)
  end

  def set_gallery
    @gallery = Gallery.find(params[:id])
  end
end
