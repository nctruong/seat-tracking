module Endpoint
  HOST          = "http://localhost:3000/api/v1/mockup/seat_trackings"
  TRIP          = "#{HOST}/trips/all"
  TODAY_TRIP    = "#{HOST}/trips/today"
  PAX_LIST      = "#{HOST}/pax/list"
  TERMINAL_PAX  = "#{HOST}/terminalpaxs"
  
  # get pax info by boarding pass
  BOARDING_PASS = "#{HOST}/boardingpass"

  SEAT_TRANS_LOG = "#{HOST}/seattranslog"

end