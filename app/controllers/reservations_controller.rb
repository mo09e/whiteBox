class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :set_applicable_gallies, only: [:new, :show, :create, :edit]
  before_action :authenticate_user!, only: [:show, :new, :edit, :update, :destroy]

  def index
  end

  def new
    @reservation = @gallery.reservations.new
  end

  def show
  end

  def create
    @reservation = @gallery.reservations.build(reservation_parameter)
    @reservation.artist_id = current_user.artist.id
    if params[:back]
       render :new
    else
      if @reservation.save
        redirect_to gallery_path(@gallery), notice: t('activerecord.attributes.reservation.create')
      else
        render :new
      end
    end
  end

  def destroy
    @reservation.destroy
    redirect_to galleries_path(current_user.id), notice: t('activerecord.attributes.reservation.destroy')
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    if @reservation.update(reservation_parameter)
      redirect_to galleries_path, notice: t('activerecord.attributes.reservation.edit')
    else
       render :edit
    end
  end

  private

  def reservation_parameter
    params.require(:reservation).permit(:start_time, :end_time, :artist_id, :gallery_id, :title)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def set_applicable_gallies
    @gallery = Gallery.find(params[:gallery_id])
  end
end
