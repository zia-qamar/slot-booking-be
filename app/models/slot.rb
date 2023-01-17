# frozen_string_literal: true

class Slot < ApplicationRecord
  validates :start, :end, presence: true
  validate :end_time_after_start_time

  scope :booked_slots, ->(start_time, end_time) { where("slots.start >= ? AND slots.end <= ?", start_time, end_time) }

  private

  def end_time_after_start_time
    return if self.end.blank? || start.blank?

    errors.add(:end, "must be after the start time") if self.end <= start
  end
end
