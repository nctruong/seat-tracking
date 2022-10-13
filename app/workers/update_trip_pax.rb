class UpdateTripPax
  include Sidekiq::Worker

  def perform(trip_id)
    trip = Trip.find_by(id: trip_id)
    Passengers::Pull.call(trip) if trip
  end
end
