# frozen_string_literal: true

class SlotsController < ApplicationController
  # rubocop:disable Metrics/AbcSize
  def new
    if params[:day].nil? || params[:duration].nil?
      render json: { message: "date and duration are required" },
             status: :bad_request
    else
      day = Date.parse(params[:day])
      duration = params[:duration].to_i
      slot_booking = SlotBookingService.new(day: day, duration: duration)
      render json: { possible_slots: slot_booking.available_slots }
    end
  end
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Metrics/AbcSize
  def book
    if params[:start_time].nil? || params[:end_time].nil?
      render json: { message: "start_time and end_time must be provided" },
             status: :bad_request
    else
      start_time = Time.zone.parse(params[:start_time])
      end_time = Time.zone.parse(params[:end_time])

      slot_booking = SlotBookingService.new(
        start_time: start_time, end_time: end_time
      )
      result = slot_booking.book
      status = :unprocessable_entity
      status = :created if result[:message] == "Slot booked successfully"
      render json: { message: result[:message] }, status: status
    end
  end
  # rubocop:enable Metrics/AbcSize
end
