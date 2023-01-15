# frozen_string_literal: true

class SlotBookingService
  def initialize(args)
    @start_time = args[:start_time]
    @end_time = args[:end_time]
    @day = args[:day]
    @duration = args[:duration]
  end

  def book
    return { message: "Slot is not available" } if overlapped_slot_exists?

    slot = Slot.new(start: @start_time, end: @end_time)

    return { message: "Failed to book slot" } unless slot.save

    { message: "Slot booked successfully", slot: slot }
  end

  # rubocop:disable Metrics/AbcSize
  def available_slots
    booked_slots = Slot.where("start >= ? AND start < ?", @day.beginning_of_day, @day.end_of_day)
    possible_slots = []

    start_time = @day.beginning_of_day
    end_time = start_time + @duration.minutes
    while start_time < @day.end_of_day
      if booked_slots.none? { |slot| slot.start < end_time && slot.end > start_time }
        possible_slots << { start: start_time, end: end_time, slot: start_time.strftime("%I:%M %p") }
      end
      start_time += 15.minutes
      end_time += 15.minutes
    end
    possible_slots
  end
  # rubocop:enable Metrics/AbcSize

  private

  def overlapped_slot_exists?
    Slot.where("(start >= ? AND start < ?) OR (slots.end > ? AND slots.end <= ?)",
               @start_time, @end_time, @start_time, @end_time).exists?
  end
end
