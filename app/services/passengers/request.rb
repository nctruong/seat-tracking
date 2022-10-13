module Passengers
  class Request < BaseService
    attr_reader :trip, :url, :http_status

    def initialize(trip, url = Endpoint::PAX_LIST)
      @trip        = trip.decorate
      @url         = url
      @http_status = nil
    end

    def call
      @http_status = response.status

      collect(JSON.parse(response.body))
    end

    private

    def response
      @response ||= conn.post(url) { |req| req.body = request_body }
    end

    def request_body
      { tripId: trip.trip_id }.to_json
    end

    def conn
      Faraday.new(headers: { 'Content-Type' => 'application/json',
                             'x-api-key'    => Rails.configuration.common.dig(:apiKey) })
    end

    def collect(passengers)
      return {} if passengers['message']

      sanitize(passengers)
    end

    def sanitize(passengers)
      passengers.try(:[], 'paxs').map do |passenger|
        next unless valid?(passenger.transform_keys!(&:underscore))

        assign_attributes(passenger)
      end.compact
    end

    def assign_attributes(passenger)
      {
        boarding_pass:                passenger['boarding_pass_no'],
        confirmed:                    false,
        name:                         passenger['name'],
        passport:                     passenger['passport_no'],
        phone:                        passenger['phone'],
        depart_port_destination_name: passenger['depart_port_destination_name'],
        depart_port_origin_name:      passenger['depart_port_origin_name'],
        trip_id:                      trip.id
      }
    end

    def valid?(passenger)
      Passenger::STATUS.values.include?(passenger['status'])
    end

    def main_keys
      @keys ||= Passenger.new.attributes.keys
    end
  end
end