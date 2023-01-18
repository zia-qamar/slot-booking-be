class SlotChannel < ApplicationCable::Channel
  def subscribed
    stream_from "slots"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
