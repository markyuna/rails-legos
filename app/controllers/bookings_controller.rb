class BookingsController < ApplicationController
  before_action :authenticate_user!

  before_action :find_user
  before_action :find_booking, only: %i[show edit update destroy]
  before_action :find_product, only: %i[new create]

  def index
    @bookings = Booking.all
    @my_bookings = Booking.where(user_id: current_user.id)
    # @my_products_booked = current_user.products.map(&:bookings).flatten
  end

  def new
    @booking = Booking.new
  end

  def show
    # @total_price = (@booking.end_date - @booking.start_date).to_i * @booking.product.price
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = @user.id
    @booking.product_id = @product.id
    @booking.total_price = ((@booking.last_day_of_booking - @booking.first_day_of_booking).to_i) * @product.price_per_day
    # authorize @booking
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  # def create
  #   @booking = @product.bookings.new(booking_params)
  #   @booking.user = current_user
  #   @booking.total_price = total_price(booking_params[:start_date], booking_params[:end_date], @product.price)

  #   if @booking.save
  #     redirect_to booking_path(@booking), notice: "Réservation créée"
  #   else
  #     render :new
  #   end
  # end

  def edit
  end

  # def update
  #   @booking.update(booking_params)
  #   @booking.total_price = total_price(booking_params[:start_date], booking_params[:end_date], @product.price)
  #   if @booking.save
  #     redirect_to booking_path(@product, @booking), notice: "Réservation modifiée"
  #   else
  #     render :edit
  #   end
  # end

  def update
    new_id = @booking.product_id
    @product = Product.find(new_id)
    @booking.update(booking_params)
    @booking.total_price = ((@booking.last_day_of_booking - @booking.first_day_of_booking).to_i) * @product.price_per_day
    # authorize @booking
    if @booking.save
      redirect_to booking_path(@product, @booking)
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:first_day_of_booking, :last_day_of_booking)
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def find_user
    @user = current_user
  end

  def find_product
    @product = Product.find(params[:product_id])
  end

  def total_price
    @product.price_per_day * @booking.date_booked.length
  end

  # def total_price(start_date, end_date, price_per_day)
  #   total_days = (end_date.to_date - start_date.to_date).to_i
  #   total_price = total_days * price_per_day
  #   return total_price / 7
  # end

  # def set_product
  #   @product = Product.find(params[:product_id])
  # end

  # def set_booking
  #   @booking = Booking.find(params[:id])
  # end

  # def set_user
  #   @user = current_user
  # end

  # def booking_params
  #   params.require(:booking).permit(:start_date, :end_date, :status, :total_price)
  # end
end
