# frozen_string_literal: true

require "rails_helper"

RSpec.describe SlotsController, type: :controller do
  describe "GET #new" do
    context "with valid params" do
      before(:each) do
        Slot.create(start: "2022-02-01T10:00:00.000Z", end: "2022-02-01T11:00:00.000Z")
        Slot.create(start: "2022-02-01T12:00:00.000Z", end: "2022-02-01T13:00:00.000Z")
        Slot.create(start: "2022-02-01T14:00:00.000Z", end: "2022-02-01T15:00:00.000Z")
        get :new, params: { date: "2022-02-01", duration: 60 }
      end

      it "returns a success response" do
        expect(response).to be_successful
      end

      it "returns the correct number of possible slots" do
        expect(JSON.parse(response.body)["possible_slots"].count).to be >= 1
      end

      it "returns the correct start and end time of the possible slots" do
        expect(JSON.parse(response.body)["possible_slots"][0]["start"]).to eq("2022-02-01T00:00:00.000Z")
        expect(JSON.parse(response.body)["possible_slots"][0]["end"]).to eq("2022-02-01T01:00:00.000Z")
      end
    end

    context "with invalid params" do
      it "returns an bad_request status if the day is not provided" do
        get :new, params: { duration: 60 }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns an bad_request status if the duration is not provided" do
        get :new, params: { date: "2022-02-01" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  require "rails_helper"

  describe "POST #book" do
    context "with valid params" do
      it "creates a new slot" do
        expect do
          post :book, params: { start_time: "2022-02-01T10:00:00.000Z", end_time: "2022-02-01T11:00:00.000Z" }
        end.to change(Slot, :count).by(1)
      end

      it "returns a 201 status code" do
        post :book, params: { start_time: "2022-02-01T10:00:00.000Z", end_time: "2022-02-01T11:00:00.000Z" }
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)["message"]).to eq("Slot is booked successfully.")
      end
    end

    context "with overlapping slot" do
      before do
        Slot.create(start: "2022-02-01T10:00:00.000Z", end: "2022-02-01T11:00:00.000Z")
      end

      it "returns a 404 status code" do
        post :book, params: { start_time: "2022-02-01T10:00:00.000Z", end_time: "2022-02-01T11:00:00.000Z" }
        expect(response).to have_http_status("404")
      end
    end

    context "with invalid params" do
      it "returns a bad request status code when end_time is less than start_time" do
        post :book, params: { start_time: "2022-02-01T10:00:00.000Z", end_time: "2022-02-01T09:00:00.000Z" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
