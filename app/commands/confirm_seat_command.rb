class ConfirmSeatCommand < BaseCommand
  attr_reader :params

  def initialize(**params)
    @params = params
  end

  def execute
    Passenger.confirm(
      params[:boarding_pass],
      params[:seat],
      params[:trip_id],
      check_in_time: params[:check_in_time]
    )

    ActionCable.server.broadcast("seat_channel")
  end
end
