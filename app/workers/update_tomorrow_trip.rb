class UpdateTomorrowTrip
  include Sidekiq::Worker

  def perform(date = Date.current.strftime("%Y-%m-%d"))
    Trips::Create.call(date)

    UpdatePassengerWorker.perform_async if Trip.count > 0
  end
end
