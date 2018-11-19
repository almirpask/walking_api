class Api::V1::DogWalkingsController < ApplicationController
  skip_before_action :verify_authenticity_token 
  def index
    page_number = params[:page].try(:[], :number)
    page_size = params[:page].try(:[], :size)
    @dog_walking = DogWalking.page(page_number).per(page_size)

    render json: @dog_walking
  end

  def show
    @dog_walking = DogWalking.find params[:id]
    
    render json: @dog_walking
  end

  def create
    @dog_walking = DogWalking.new dog_walking_params
    if @dog_walking.save
      render json: @dog_walking
    else
     render json: 'error'
    end
  end

  private

  def dog_walking_params
    params.permit(
      :price,
      :duration,
      :latitude,
      :longitude,
      :start,
      :finish
    )
  end
end
