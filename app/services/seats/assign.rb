module Seats
  class Assign < BaseService
    attr_reader :trip_id, :seat, :boarding_pass, :opt

    def initialize(trip_id:, seat:, boarding_pass:, opt: {})
      @trip_id       = trip_id
      @seat          = seat
      @boarding_pass = boarding_pass
      @opt           = opt
    end

    def call
      find_passenger_holding_seat
      find_current_pax
      return if @pax.nil?

      exist_pax_at_seat? ? replace_pax_at_seat : set_seat
    end

    def self.call(**args)
      service = new(**args)
      service.call
    end

    private

    def replace_pax_at_seat
      @pax.update(attribute)

      @seat_pax.dup.update(attribute.merge(trip_id: @pax.trip_id, seat: nil, confirmed: false, check_in_time: nil))
      @seat_pax.deactivate!
    end

    def find_current_pax
      @pax ||= Passenger.joins(:trip).find_by(boarding_pass: boarding_pass.strip, trips: { trip_id: trip_id&.strip })
    end

    def set_seat
      if @pax.seat?
        @pax.dup.update(attribute.merge(trip_id: @pax.trip_id))
        @pax.deactivate!
      else
        @pax.update(attribute)
      end
    end

    def exist_pax_at_seat?
      @seat_pax.present? && @seat_pax != @pax
    end

    def find_passenger_holding_seat
      @seat_pax ||= Passenger.joins(:trip).find_by(trips: { trip_id: trip_id }, seat: seat)
    end

    def attribute
      { seat: seat, confirmed: true }.merge(opt)
    end
  end
end