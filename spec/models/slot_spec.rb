# frozen_string_literal: true

require "rails_helper"

RSpec.describe Slot, type: :model do
  describe "validations" do
    it "is invalid without a start time" do
      slot = Slot.new(end: "2022-02-01T11:00:00.000Z")
      expect(slot).to be_invalid
    end

    it "is invalid without an end time" do
      slot = Slot.new(start: "2022-02-01T10:00:00.000Z")
      expect(slot).to be_invalid
    end

    it "is invalid if the end time is before the start time" do
      slot = Slot.new(start: "2022-02-01T11:00:00.000Z", end: "2022-02-01T10:00:00.000Z")
      expect(slot).to be_invalid
    end
  end
end
