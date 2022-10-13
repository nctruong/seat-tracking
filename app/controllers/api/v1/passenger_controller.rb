class Api::V1::PassengerController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    passenger = Passenger.includes(:trip)
                         .find_by(boarding_pass: params[:boarding_pass])
    render json: {
      paxName:                   passenger.name,
      departTripId:              passenger.trip.trip_id,
      boardingPassNo:            passenger.boarding_pass,
      departDate:                passenger.trip.depart_date,
      departPortDestinationName: passenger.depart_port_destination_name
    }
  end

end
