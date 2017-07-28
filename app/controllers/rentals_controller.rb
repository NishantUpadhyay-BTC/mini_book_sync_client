class RentalsController < ApplicationController
  def new
    @rental = Rental.new
  end

  def create
    response = SyncApi::Client.create_rental({rental: { name: rental_params[:name], daily_rate: rental_params[:daily_rate] } })
    binding.pry
  end

  private

  def rental_params
    params.require(:rental).permit(:name, :daily_rate)
  end
end
