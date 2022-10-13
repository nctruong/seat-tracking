class Api::V1::Mockup::SeatTrackings::BoardingpassController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: {
      "boardingPassNo":          "C14582732",
      "departPortOriginId":      "TMF",
      "departPortDestinationId": "BTC",
      "departDate":              "2021-12-31",
      "departETD":               "12:30",
      "departTimeRegion":        "SG",
      "paxName":                 "YONATHAN MEPING8",
      "paxPassportNo":           "XXX6462"
    }
  end
end
