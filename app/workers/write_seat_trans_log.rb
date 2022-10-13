class WriteSeatTransLog
  include Sidekiq::Worker

  def perform
    Clouds::Sync.call
    ActionCable.server.broadcast("seat_channel", {})
  end
end
