class EndTrip
  include Sidekiq::Worker

  def perform
    return unless over?(trip)

    terminate(trip)
    broadcast_seat_channel
  end

  private

  def trip
    @trip ||= Trips::GetCurrentTrip.call
  end

  def terminate(trip)
    Trips::End.call(trip, false)
  end

  def over?(trip)
    Time.current > trip.decorate.estimate_arrived_time
  end

  def broadcast_seat_channel
    ActionCable.server.broadcast("seat_channel", { full_page: true })
  end
end


