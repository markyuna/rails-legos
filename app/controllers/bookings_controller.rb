class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_booking, only: %i[show edit update destroy]
  before_action :set_product, only: %i[new create update]

  def index
    @my_bookings = Booking.where(user_id: current_user.id)
    # @my_products_booked = current_user.products.map(&:bookings).flatten
  end

  def new
    @booking = Booking.new
  end

  def show
    @total_price = (@booking.last_day_of_booking - @booking.first_day_of_booking).to_i * @booking.product.price_per_day
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = @user.id
    @booking.product_id = @product.id
    @booking.total_price = total_price(@booking, @product)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @booking.update(booking_params)
    @product = Product.find(@booking.product_id)
    @booking.total_price = total_price(@booking, @product)
    if @booking.save
      redirect_to booking_path(@booking)   
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
    redirect_to product_booking_path(@product, @booking), method: :delete, data: {confirm: "sure?"}, class: "p-2"

  end

  private

  def booking_params
    params.require(:booking).permit(:first_day_of_booking, :last_day_of_booking, :total_price)
  end

  def total_price(booking, product)
    (booking.last_day_of_booking - booking.first_day_of_booking).to_i * product.price_per_day
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_user
    @user = current_user
  end
end
