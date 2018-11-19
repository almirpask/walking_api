require 'rails_helper'

RSpec.describe Api::V1::DogWalkingsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      dog_walking = create(:dog_walking)
      get :show, params: { id: dog_walking.id } 
      expect(response).to have_http_status(:success)
    end
    
    it "returns http unprocessable_entity" do
      get :show, params: { id: 0 } 
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "Check if the dog_walker time is igual 0" do
      dog_walking = create(:dog_walking)
      get :show, params: { id: dog_walking.id }

      response_body = JSON.parse(response.body)

      expect(response_body.fetch('data').fetch('attributes').fetch('total-time')).to eq(0)
    end

    it "Check if the dog_walker time is igual 0" do
      dog_walking = create(:dog_walking)
      get :show, params: { id: dog_walking.id }

      response_body = JSON.parse(response.body)

      expect(response_body.fetch('data').fetch('attributes').fetch('total-time')).to eq(0)
    end
  end

  # describe "GET #create" do
  #   it "returns http success" do
  #     get :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
