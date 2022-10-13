module Passengers
  class Pull < BaseService
    attr_reader :trip, :reader, :errors

    def initialize(trip, reader = Request)
      @trip   = trip
      @reader = reader.new(trip)
      @errors = []
    end

    def call
      begin
        attributes = reader.call

        if read_successful?
          empty_response?(attributes) ? no_passenger : create_passengers(attributes)
        else
          request_help
        end

      rescue Faraday::ConnectionFailed
        @errors << 'Connection failed'
      end

      @errors
    end

    private

    def no_passenger
      @errors << 'No passenger found'
    end

    def request_help
      @errors << "HTTP STATUS #{reader.http_status}. Pls contact developers for help"
    end

    def empty_response?(attributes)
      attributes.blank?
    end

    def read_successful?
      reader.http_status == 200
    end

    def create_passengers(attributes)
      attributes.map { |att| att.merge(trip_id: trip.id) }.each do |attr|
        next if data_exist?(attr)

        Passenger.create(attr)
      end
    end

    def data_exist?(attr)
      Passenger.joins(:trip)
               .exists?(attr.slice(:passport)
                            .merge(trips: { trip_id: trip.trip_id }))
    end
  end
end
