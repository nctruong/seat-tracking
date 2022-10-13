module Confirmable
  extend ActiveSupport::Concern

  included do
    def self.confirm(boarding_pass, seat, trip_id, opt = {})
      self.find_by(boarding_pass: boarding_pass).confirm(seat, trip_id, opt)
    end

    def confirm(seat, trip_id, opt = {})
      assign_seat(opt, seat, trip_id)
    end
  end

  private

  def assign_seat(opt, seat, trip_id)
    Seats::Assign.call(boarding_pass: boarding_pass, seat: seat, trip_id: trip_id, opt: opt)
  end
end
