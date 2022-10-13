class PassengerController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :create_facade
  before_action :set_trip, only: %w(update_passenger_list get_terminal_pax_list reload_list)

  def reload_list
  end

  def update_passenger_list
    Passengers::Pull.call(@facade.trip)
  end

  def history
    @passengers = @facade.pax(params[:passport])
  end

  def assign_seat
    @passenger = Passenger.find(seat_params[:id])

    ConfirmSeatCommand.execute(
      trip_id:       @passenger.trip_id,
      seat:          seat_params[:seat],
      boarding_pass: @passenger.boarding_pass,
      check_in_time: Time.current.strftime("%Y-%m-%d %H:%M")
    )
  end

  def search
    @passengers = if params[:name]
                    params[:trip_id] ? search_passenger(params[:name]) : all_pax
                  else
                    params[:trip_id] ? load_trip_passengers : all_pax
                  end
  end

  private

  def create_facade
    @facade = ::PaxListFacade.new
  end

  def all_pax
    @passenger_history = if params[:name]
                           @facade.pax_history(Passenger.search_by_name(params[:name]).pluck(:id))
                         else
                           @facade.pax_history
                         end
  end

  def load_trip_passengers
    @trip = @facade.trip(Trip.find_by(trip_id: params[:trip_id]))
    @trip.passengers
  end

  def search_passenger(name)
    @trip = Trip.find_by(trip_id: params[:trip_id])
    @trip.passengers.search_by_name(name)
         .view_order
         .map { |p| PassengerPresenter.new(p) }
  end

  def set_trip
    @trip = Trip.find_by(trip_id: params[:trip_id]) || @facade.trip
  end

  def seat_params
    params.permit(:id, :seat)
  end
end
