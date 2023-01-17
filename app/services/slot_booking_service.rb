# frozen_string_literal: true

class SlotBookingService
  include ApiResponse

  attr_reader :start_time, :end_time
  def initialize(start_time, end_time)
    @start_time = start_time
    @end_time = end_time
  end

  def call
    { data: book, status: map_status(:success) }
  rescue StandardError => e
    { data: [], status: map_status(e.message) }
  end

  private

  def book
    raise "api_error" if start_time.nil? || end_time.nil?
    raise "not_found" if overlapped_slot_exists?

    slot = Slot.new(start: Time.parse(start_time), end: Time.parse(end_time))

    raise "api_error" unless slot.save

    { message: "Slot is booked successfully.", slot: slot }
  end

  def overlapped_slot_exists?
    Slot.where("(start >= ? AND start < ?) OR (slots.end > ? AND slots.end <= ?)",
               start_time, end_time, start_time, end_time).exists?
  end
end
