class RoomsController < ApplicationController
  before_action :set_q, only: [:index, :search]

  def index
    @user = User.find(current_user.id)
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    if @room.save
      flash[:notice] = "ルーム情報を新規登録しました"
      redirect_to room_path(@room)
    else
      render "new"
    end
  end

  def search
    @results = @q.result(distinct: true)
    if @q_header
      @results = @q_header.result(distinct: true)
    end
  end

  def show
    @room = Room.find(params[:id])
    @user = @room.user
    @booking = Booking.new
  end

  private
  def set_q
    @q = Room.ransack(params[:q])
  end
  
  def room_params
    params.require(:room).permit(:user_id, :room_image, :room_name, :description, :fee, :address)
  end

end
