class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:id])
    @current_entries = current_user.entries
    @my_room_ids = []
    @current_entries.each do |entry|
      @my_room_ids << entry.room.id
    end
    @another_entries = Entry.where(room_id: @my_room_ids).where('user_id != ?',@user.id)
  end

  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
