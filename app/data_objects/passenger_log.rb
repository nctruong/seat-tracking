class PassengerLog < SimpleDelegator
  def json
    {
      "PassportNo":     passport,
      "BoardingPassNo": boarding_pass,
      "TransType":      "check-in",
      "PaxName":        name,
      "TripId":         trip.trip_id,
      "SeatNo":         seat,
      "CheckInTime":    check_in_time
    }
  end
end