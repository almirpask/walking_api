require 'rails_helper'

RSpec.describe Api::V1::DogWalkingsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "returns a empty array" do
      get :index

      response_body = JSON.parse(response.body)
      expect(response_body.fetch('data').length).to eq(0)
    end

    it "must return 2 dog_walkings" do
      create(:dog_walking)
      create(:dog_walking)
      get :index

      response_body = JSON.parse(response.body)
      expect(response_body.fetch('data').length).to eq(2)
    end

    it "must return 3 dog_walkings without next_walks filter" do
      dog_walking1 =  create(:dog_walking)
      dog_walking2 =  create(:dog_walking)
      dog_walking3 =  create(:dog_walking)

      put :start_walk, params: { dog_walking_id: dog_walking1.id }
      put :finish_walk, params: { dog_walking_id: dog_walking1.id }
      get :index

      response_body = JSON.parse(response.body)
      expect(response_body.fetch('data').length).to eq(3)
    end

    it "must return 2 dog_walkings with next_walks filter" do
      dog_walking1 =  create(:dog_walking)
      dog_walking2 =  create(:dog_walking)
      dog_walking3 =  create(:dog_walking)

      put :start_walk, params: { dog_walking_id: dog_walking1.id }
      put :finish_walk, params: { dog_walking_id: dog_walking1.id }
      get :index, params: {next_walks: true}

      response_body = JSON.parse(response.body)
      expect(response_body.fetch('data').length).to eq(2)
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
  end

  describe "POST #create" do
    it "Create a new dog_walking" do
      expect {create(:dog_walking)}.to change { DogWalking.count }.by(1)
    end

    it "returns http created" do
      post :create, params: { duration: 60, latitude: -23.476104, longitude: -46.641790, pets: 1 } 

      expect(response).to have_http_status(:created)
    end

    it "have duration of 60 and should have a price of 35" do
      post :create, params: { duration: 60, latitude: -23.476104, longitude: -46.641790, pets: 1 } 
      response_body = JSON.parse(response.body)

      expect(response_body.fetch('data').fetch('attributes').fetch('price')).to eq(35)
    end

    it "have duration of 60 and should have a price of 55" do
      post :create, params: { duration: 60, latitude: -23.476104, longitude: -46.641790, pets: 2 } 
      response_body = JSON.parse(response.body)

      expect(response_body.fetch('data').fetch('attributes').fetch('price')).to eq(55)
    end

    it "have duration of 30 and should have a price of 25" do
      post :create, params: { duration: 30, latitude: -23.476104, longitude: -46.641790, pets: 1 } 
      response_body = JSON.parse(response.body)

      expect(response_body.fetch('data').fetch('attributes').fetch('price')).to eq(25)
    end

    it "have duration of 30 and should have a price of 40" do
      post :create, params: { duration: 30, latitude: -23.476104, longitude: -46.641790, pets: 2 } 
      response_body = JSON.parse(response.body)

      expect(response_body.fetch('data').fetch('attributes').fetch('price')).to eq(40)
    end

    it "should fail without a duration" do
      post :create, params: { latitude: -23.476104, longitude: -46.641790, pets: 2 }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
  describe "PUT #start_walk" do
    it "Check if start_walk returns a time" do
      dog_walking = create(:dog_walking)

      put :start_walk, params: { dog_walking_id: dog_walking.id }

      response_body = JSON.parse(response.body)
      time = response_body.fetch('data').fetch('attributes').fetch('start')
      start = Time.new(time)
      expect(start).to be_a(Time)
    end
  end
  describe "PUT #finish_walk" do
    it "Check if finish returns a time" do
      dog_walking = create(:dog_walking)
      put :start_walk, params: { dog_walking_id: dog_walking.id }

      put :finish_walk, params: { dog_walking_id: dog_walking.id }

      response_body = JSON.parse(response.body)
      time = response_body.fetch('data').fetch('attributes').fetch('finish')
      start = Time.new(time)
      expect(start).to be_a(Time)
    end

    it "Should return a empty data" do
      dog_walking = create(:dog_walking)

      put :finish_walk, params: { dog_walking_id: dog_walking.id }

      expect(response).to have_http_status(:no_content)
    end
  end
end
