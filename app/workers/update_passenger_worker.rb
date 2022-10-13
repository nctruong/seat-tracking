class UpdatePassengerWorker
  include Sidekiq::Worker

  def perform
    Trip.all.each do |trip|
      if time_passed?(trip)
        Passengers::Pull.call(trip)
      else
        schedule(trip, 20.minutes)
        schedule(trip, 30.minutes)
      end
    end
  end

  private

  def time_passed?(trip)
    trip.decorate.depart_date_time < Time.current
  end

  def schedule(trip, minutes)
    UpdateTripPax.perform_in(duration(trip).minutes - minutes, trip.id)
  end

  def duration(trip)
    (trip.decorate.depart_date_time.in_time_zone('Singapore') - Time.current) / 1.minute
  end
end
