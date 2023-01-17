# frozen_string_literal: true

class SlotAvailabilityService
  include ApiResponse

  attr_reader :date, :duration
  def initialize(date, duration)
    @date = date
    @duration = duration
  end

  def call
    { data: available_slots, status: map_status(:success) }
  rescue StandardError => e
    { data: [], status: map_status(e.message) }
  end

  private

  # rubocop:disable Metrics/AbcSize
  def available_slots
    raise "api_error" if date.nil? || duration.nil?

    starting_time = Date.parse(date).beginning_of_day
    ending_time = Date.parse(date).end_of_day
    booked_slots = Slot.booked_slots(starting_time, ending_time)
    available_slots = []

    increment = duration.to_i * 60
    while starting_time < ending_time
      slot_ending_time = starting_time + increment
      unless booked_slots.any? { |slot| (slot_ending_time > slot[:start] && starting_time < slot[:end]) }
        available_slots << { start: starting_time, end: slot_ending_time, slot: starting_time.strftime("%I:%M %p") }
      end
      starting_time += increment
    end
    available_slots
  end
  # rubocop:enable Metrics/AbcSize
end
