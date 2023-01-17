# frozen_string_literal: true

class SlotsController < ApplicationController
  def new
    slot_availability = SlotAvailabilityService.new(
      params[:date], params[:duration]
    )
    result = slot_availability.call
    render json: { possible_slots: result[:data] }, status: result[:status]
  end

  def book
    slot_booking = SlotBookingService.new(
      params[:start_time], params[:end_time]
    )
    result = slot_booking.call
    render json: result[:data], status: result[:status]
  end
end
