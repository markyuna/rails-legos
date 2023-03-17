class BookingsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_product, only: [:new, :create, :destroy]

  def accept
    @booking = Booking.find(params[:id])
    authorize @booking, :accept?

    @booking.update(status: "accepted")
    @booking.product.update(status: true)

    redirect_to my_products_path, notice: "Réservation acceptée"
  end

  def reject
    @booking = Booking.find(params[:id])
    @booking.update(status: "rejected")
    @booking.product.update(status: false)
    redirect_to my_products_path, notice: "Réservation refusée"
  end

  def index
    @bookings = Booking.all
    @my_bookings = Booking.where(user_id: current_user.id)
    @my_products_booked = current_user.products.map(&:bookings).flatten
  end

  def new
    @booking = Booking.new
  end

  def show
    @total_price = (@booking.end_date - @booking.start_date).to_i * @booking.product.price
  end


  def create
    @booking = @product.bookings.new(booking_params)
    @booking.user = current_user
    @booking.total_price = total_price(booking_params[:start_date], booking_params[:end_date], @product.price)

    if @booking.save
      redirect_to booking_path(@booking), notice: "Réservation créée"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @booking.update(booking_params)
    @booking.total_price = total_price(booking_params[:start_date], booking_params[:end_date], @product.price)
    if @booking.save
      redirect_to booking_path(@product, @booking), notice: "Réservation modifiée"
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path, notice: "Réservation supprimée"
  end

  private

  def total_price(start_date, end_date, price_per_day)
    total_days = (end_date.to_date - start_date.to_date).to_i
    total_price = total_days * price_per_day
    return total_price / 7
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

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status, :total_price)
  end
end
