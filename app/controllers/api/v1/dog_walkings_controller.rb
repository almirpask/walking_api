class Api::V1::DogWalkingsController < ApplicationController
  skip_before_action :verify_authenticity_token 
  def index
    @dog_walking = DogWalking.all
    respond_to do |format|
      format.json { render json: @dog_walking}
    end
  end

  def show
    @dog_walking = DogWalking.find params[:id]
    respond_to do |format|
      format.json { render json: @dog_walking}
    end
  end

  def create
    @dog_walking = DogWalking.new dog_walking_params
    if @dog_walking.save
      respond_to do |format|
        format.json { render json: @dog_walking}
      end
    else
      respond_to do |format|
        format.json { render json: 'error'}
      end
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
