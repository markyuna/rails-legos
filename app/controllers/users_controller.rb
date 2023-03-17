class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show]

  def show
    # @products = current_user.products.all
    @product = current_user.reviews.all
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
