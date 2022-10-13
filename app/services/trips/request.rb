module Trips
  class Request < BaseService
    attr_reader :depart_date

    # @depart_date YYYY-MM-DD
    def initialize(depart_date = nil)
      @depart_date = depart_date || Date.current.strftime("%Y-%m-%d")
    end

    def call
      filter_attributes(http_get)
    end

    private

    def http_get
      JSON.parse(response.body)
    end

    def response
      conn.post(Endpoint::TRIP, &method(:request))
    end

    def request(req)
      req.body = { departDate: depart_date, vesselID: Rails.configuration.common.dig(:vessel_id) }.to_json
    end

    def conn
      @conn ||= Faraday.new(headers: { 'Content-Type' => 'application/json',
                                       'x-api-key'    => Rails.configuration.common.dig(:apiKey) })
    end

    def filter_attributes(trips)
      trips.map do |trip|
        trip.transform_keys!(&:underscore).slice!(*main_keys)
        convert_timezone(trip)
        trip['trip_id'] = trip['id']
        trip
      end
    end

    def convert_timezone(trip)
      if trip['port_origin_country'] == 'INDONESIA'
        trip['etd'] = plus_1hour(trip['etd'])
      else
        trip['eta'] = plus_1hour(trip['eta'])
      end
    end

    def main_keys
      @keys ||= Trip.new.attributes.keys
    end

    def plus_1hour(hour_min)
      (hour_min.to_time + 1.hour).strftime("%H:%M")
    end
  end
end