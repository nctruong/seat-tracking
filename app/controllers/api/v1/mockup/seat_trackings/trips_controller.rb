class Api::V1::Mockup::SeatTrackings::TripsController < ApplicationController
  skip_before_action :verify_authenticity_token # FOR DEMO PURPOSE

  def all
    render json: [
                   {
                     "id":                  "220112SAMPLE0920",
                     "ticketFareTypeId":    "",
                     "isOpenTrip":          false,
                     "portOriginId":        "BTC",
                     "portOriginName":      "Testing Center",
                     "portDestinationId":   "TMF",
                     "portDestinationName": "TanahMerah",
                     "departDate":          departDate,
                     "etd":                 "22:00",
                     "arrivalDate":         nil,
                     "eta":                 "11:30",
                     "timeRegion":          "WIB",
                     "vesselID":            "007",
                     "vesselName":          "James Bond Vessel",
                   },
                   {
                     "id":                  "220112SAMPLE1000",
                     "ticketFareTypeId":    "",
                     "isOpenTrip":          false,
                     "portOriginId":        "BTC",
                     "portOriginName":      "Testing Center",
                     "portDestinationId":   "TMF",
                     "portDestinationName": "TanahMerah",
                     "departDate":          departDate,
                     "etd":                 "10:00",
                     "arrivalDate":         nil,
                     "eta":                 "12:00",
                     "timeRegion":          "WIB",
                     "vesselID":            "007",
                     "vesselName":          "James Bond Vessel",
                   },
                 ]

  end

  private

  def departDate
    Rails.cache.fetch("Mockup.departDate", expires_in: 24.hours) do
      Date.current.strftime("%Y-%m-%d")
    end
  end
end
