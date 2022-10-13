module Trips
  class Reset < BaseService
    attr_reader :depart_date

    # @depart_date YYYY-MM-DD
    def initialize(depart_date = nil)
      @depart_date = depart_date || Rails.configuration.common.dig(:depart_date) || Date.current.strftime("%Y-%m-%d")
    end

    def call
      clean_up
      pull_trips

      broadcast_seat_channel
    end

    private

    def pull_trips
      UpdateTomorrowTrip.perform_async(depart_date)
    end

    def clean_up
      CleanData.perform_async
    end

    def broadcast_seat_channel
      ActionCable.server.broadcast("seat_channel", {})
    end
  end
end
