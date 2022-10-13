class Api::V1::TripController < ApplicationController
  skip_before_action :verify_authenticity_token

  def confirm
    ConfirmSeatCommand.execute(params)

    render json: { status: :success }
  end

  def end_trip
    @success = EndTripCommand.execute(params)
  end

end
