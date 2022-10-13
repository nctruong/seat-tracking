class SeatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "seat_channel"
  end

  def unsubscribed
    stop_all_streams
  end
end
