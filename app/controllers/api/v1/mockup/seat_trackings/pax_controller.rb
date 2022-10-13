class Api::V1::Mockup::SeatTrackings::PaxController < ApplicationController
  skip_before_action :verify_authenticity_token

  def list
    render json: { "paxs": create_pax }
  end

  private

  def create_pax
    Rails.cache.fetch("Mockup.pax", expires_in: 24.hours) do
      [*1..10].map { |id| fake_pax_attributes(id) }
    end
  end

  def fake_pax_attributes(id)
    {
      "id":             id,
      "bookingNo":      Faker::Number.number(digits: 7),
      "passportNo":     Faker::Number.number(digits: 10),
      "name":           Faker::Name.name,
      "boardingPassNo": Faker::Number.number(digits: 8),
      "status":         "CK",
      "statusName":     "RESERVED",
      "trip_id":        params[:tripId]
    }
  end
end
