class Api::V1::DogWalkingsController < ApplicationController
  skip_before_action :verify_authenticity_token 
  def index
    page_number = params[:page].try(:[], :number)
    page_size = params[:page].try(:[], :size)

    @dog_walking = next_walks_filter(DogWalking.page(page_number).per(page_size))
    render json: @dog_walking
  end

  def show
    @dog_walking = DogWalking.find params[:id]

    render json: @dog_walking, serializer: DogWalkingSerializerShow
  end

  def create
    @dog_walking = DogWalking.new dog_walking_params
    walk_price
    if @dog_walking.save
      render json: @dog_walking
    else
      render json: 'error'
    end
  end

  def start_walk
    @dog_walking = DogWalking.find(params[:dog_walking_id])
    if @dog_walking.start.nil?
      if @dog_walking.update(start: Time.now, status: :in_progress)
        render json: @dog_walking
      else
        render json: 'error'
      end
    end
  end

  def finish_walk
    @dog_walking = DogWalking.find(params[:dog_walking_id])
    if @dog_walking.status == 'in_progress'
      if @dog_walking.update(finish: Time.now, status: :finished)
        render json: @dog_walking
      else
        render json: 'error'
      end
    end
  end

  private

  def next_walks_filter(scope)
    if params[:next_walks]
      scope.next_walks
    else
      scope
    end
  end

  def walk_price
    if @dog_walking.duration == 60
      @dog_walking.price = ((@dog_walking.pets - 1) * 20) + 35
    else
      @dog_walking.price = ((@dog_walking.pets - 1) * 15) + 25
    end
  end

  def dog_walking_params
    params.permit(
      :price,
      :duration,
      :latitude,
      :longitude,
      :start,
      :finish,
      :pets,
      :scheduled_day
    )
  end
end
