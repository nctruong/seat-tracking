class PaxListFacade
  def pax_in_order
    @passengers ||= Passenger.with_trip(trip).view_order.map { |p| PassengerPresenter.new(p) }
  end

  def pax_history(ids = nil)
    Passenger.with_passport(ids).map { |passenger| OpenStruct.new(passenger) }
  end

  def pax_unconfirmed(trip)
    Passenger.with_trip(trip).unconfirmed.view_order
  end

  def pax(passport)
    Passenger.unscoped.where(passport: passport).order(check_in_time: :desc)
  end

  def trip(trip = nil)
    @trip ||= trip || Trips::GetCurrentTrip.call
  end

  def seats
    @passengers.pluck(:seat).compact.each_with_object({}) { |seat, obj| obj[seat] = true }
  end

  def confirmed_count
    "(#{@passengers.count { |p| p.seat.present? }}"
  end

  def count_sync
    Passengers::CountRecordSynchronized.call
  end
end