module Amazon
  class UpdateSeat < BaseService
    attr_reader :args

    def initialize(args)
      message = JSON.parse(args, symbolize_names: true)[:Message]
      @args   = JSON.parse(message, symbolize_names: true)
    end

    def call
      Passenger.confirm(
        args[:boardingPassNo],
        args[:seatNo],
        args[:tripId],
        sent_cloud:    false,
        check_in_time: args[:checkInTime]
      )

      broadcast_seat_channel
    end

    private

    def broadcast_seat_channel
      ActionCable.server.broadcast("seat_channel", {})
    end
  end
end