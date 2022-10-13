module Trips
  class Pull < BaseService
    attr_reader :depart_date

    def initialize(depart_date=nil)
      @depart_date = depart_date || Rails.configuration.common.dig(:depart_date) || Date.current.strftime("%Y-%m-%d")
    end

    def call
      Trip.import(Request.call(depart_date))
    end
  end
end
