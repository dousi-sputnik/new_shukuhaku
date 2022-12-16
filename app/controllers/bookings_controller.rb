class BookingsController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @bookings = @user.bookings 
    if @bookings.present?
      @booking = current_user.bookings.last
      @room = @booking.room
    end
  end

  #def new
  #end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    if params[:back]
      @room = @booking.room
      @user = @room.user
      render "rooms/show"
    elsif @booking.save
      flash[:notice] = "新規予約を作成しました"
      redirect_to booking_path(@booking)
    else 
      flash[:notice] = "新規予約に失敗しました"
      render "pages/top"
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @room = @booking.room 
  end

  def confirm
    @room = Room.find(params[:booking][:room_id])
    @booking = Booking.new(booking_params)
    @user = @room.user
    @booking.user_id = current_user.id
    @booking.room_id = @room.id
    if @booking.invalid?
      render "rooms/show"
    else
      @days = (@booking.end_date - @booking.start_date).to_i
      @booking.total_price = (@room.fee * @booking.person * @days).to_i
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :person, :total_price, :room_id, :user_id )
  end
end
