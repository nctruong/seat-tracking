class TripValidation
  class << self

    def today_is_loaded?
      Trip.exists?(depart_date: today)
    end

    private

    def today
      Rails.cache.fetch("TripValidation.today", expires_in: 24.hours) do
        Date.current.strftime("%Y-%m-%d")
      end
    end

  end

end
