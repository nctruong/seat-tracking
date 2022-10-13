module Trips
  class GetCurrentTrip < BaseService
    def call
      current_trip = nil

      trips.each do |trip|
        next if trip.ended?

        current_trip = trip
        break
      end
      current_trip ? current_trip : trips.last
    end

    private

    def trips
      @trips ||= Trip.order(:etd)
    end
  end
end