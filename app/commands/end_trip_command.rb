class EndTripCommand < BaseCommand
  attr_reader :trip

  def initialize(params)
    @trip = Trip.find_by(trip_id: params[:trip_id])
  end

  def execute
    passenger_present? ? terminate_trip : update_ended_status

    broadcast_channel
    success?
  end

  private

  def update_ended_status
    trip.update(ended: true)
  end

  def passenger_present?
    trip.passengers.any?
  end

  def success?
    Passenger.with_trip(trip).unsent_cloud.blank?
  end

  def broadcast_channel
    ActionCable.server.broadcast("seat_channel", { full_page: true })
  end

  def terminate_trip
    Trips::End.call(trip, only_valid = false)
  end
end