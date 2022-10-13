class CleanData
  include Sidekiq::Worker

  def perform
    Trip.delete_all
    Passenger.unscoped.delete_all
  end
end
