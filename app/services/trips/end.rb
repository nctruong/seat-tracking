module Trips
  class End < BaseService
    attr_reader :only_valid, :trip
    alias_method :only_valid?, :only_valid

    def initialize(trip, only_valid = true)
      @only_valid = only_valid
      @trip       = trip
    end

    def call
      mark_not_scanned unless only_valid?

      send if passengers.any?
    end

    private

    def send
      mark_sent if response.status == 200
    end

    def response
      conn.post(Endpoint::SEAT_TRANS_LOG) { |req| req.body = request.to_json }
    end

    def conn
      Faraday.new(headers: { 'Content-Type' => 'application/json',
                             'x-api-key'    => Rails.configuration.common.dig(:apiKey) })
    end

    def request
      { "SeatData": passengers.map { |passenger| ::PassengerLog.new(passenger).json } }

    end

    def passengers
      @passengers ||= Passenger.with_trip(trip).ready_to_send_cloud.order(:updated_at)
    end

    def mark_not_scanned
      Passenger.with_trip(trip).unconfirmed.update_all(seat:          'Not Scanned',
                                                       check_in_time: Time.current.strftime("%Y-%m-%d %H:%M"))
    end

    def mark_sent
      passengers.update_all(sent_cloud: true)
      @trip.update(ended: true)
    end
  end
end
