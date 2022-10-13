# == Schema Information
#
# Table name: passengers
#
#  id                           :bigint           not null, primary key
#  active                       :boolean          default(TRUE)
#  boarding_pass                :string
#  check_in_time                :string
#  confirmed                    :boolean
#  deck                         :integer
#  depart_port_destination_name :string
#  depart_port_origin_name      :string
#  name                         :string
#  passport                     :string
#  phone                        :string
#  seat                         :string
#  sent_cloud                   :boolean          default(FALSE)
#  trip_no                      :string
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  trip_id                      :uuid
#
# Indexes
#
#  index_passengers_on_active         (active)
#  index_passengers_on_boarding_pass  (boarding_pass)
#  index_passengers_on_check_in_time  (check_in_time)
#  index_passengers_on_passport       (passport)
#  index_passengers_on_sent_cloud     (sent_cloud)
#
require 'rails_helper'

RSpec.describe Passenger, type: :model do
  before(:each) do
    @trip = create(:trip)
    @pax1 = create(:passenger, trip_id: @trip.id, boarding_pass: 1)
    @pax2 = create(:passenger, trip_id: @trip.id, boarding_pass: 2)
  end

  describe '#confirm' do
    context 'when seat is available - no one holding' do
      it 'assign this seat to this pax' do
        Passenger.confirm(
          @pax1.boarding_pass,
          'V1',
          @trip.trip_id
        )
        expect(@pax1.reload.seat).to eq('V1')
      end
    end

    context 'when seat is being held by other pax' do
      it 'set other pax inactive' do
        @pax1.update(seat: 'V1')
        Passenger.confirm(
          @pax2.boarding_pass,
          'V1',
          @trip.trip_id
        )
        expect(Passenger.inactive.last).to eq(@pax1)
      end

      it 'set other pax empty seat' do
        @pax1.update(seat: 'V1')
        Passenger.confirm(
          @pax2.boarding_pass,
          'V1',
          @trip.trip_id
        )

        expect(Passenger.find_by(boarding_pass: @pax1.boarding_pass).seat).to eq(nil)
      end

      it 'set other pax not confirmed yet' do
        @pax1.update(seat: 'V1')
        Passenger.confirm(
          @pax2.boarding_pass,
          'V1',
          @trip.trip_id
        )
        expect(Passenger.find_by(boarding_pass: @pax1.boarding_pass).confirmed).to be_falsey
      end

      it 'assign this seat to current pax' do
        @pax1.update(seat: 'V1')
        Passenger.confirm(
          @pax2.boarding_pass,
          'V1',
          @trip.trip_id
        )
        expect(Passenger.find_by(boarding_pass: @pax2.boarding_pass).seat).to eq('V1')
      end
    end

    context 'when pax wants to change seat' do
      it 'sets current record inactive - having this seat' do
        @pax1.update(seat: 'V1')
        Passenger.confirm(
          @pax1.boarding_pass,
          'V2',
          @trip.trip_id
        )
        expect(Passenger.inactive.find_by(boarding_pass: @pax1.boarding_pass).active).to be_falsey
      end

      it 'create new pax record and assign seat' do
        @pax1.update(seat: 'V1')
        Passenger.confirm(
          @pax1.boarding_pass,
          'V2',
          @trip.trip_id
        )
        expect(Passenger.find_by(boarding_pass: @pax1.boarding_pass).seat).to eq('V2')
      end
    end
  end
end
