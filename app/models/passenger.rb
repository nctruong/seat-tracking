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
class Passenger < ApplicationRecord
  include Seachable
  include Confirmable

  enum deck: { main: 0, lower: 1, first_deck: 2, second_deck: 3, third_deck: 4 }

  STATUS = {
    check_in: 'CK',
    boarded:  'BD'
  }

  belongs_to :trip

  default_scope -> { where(active: true) }

  scope :with_trip, -> (trip) { where(trip: trip) }
  scope :view_order, -> { order(:confirmed, :deck, :name) }
  scope :unconfirmed, -> { where(confirmed: false) }
  scope :with_passport, -> (ids = nil) {
    sql = 'SELECT passport, COUNT(passport) as counter
      FROM passengers
      WHERE passengers.active IS True'
    sql += ' AND id in (' + ids.join(', ') + ')' if ids.present?
    sql += ' GROUP BY passport'

    ActiveRecord::Base.connection.execute(sql)
  }
  scope :with_boarding_pass, -> (boarding_pass) { where(boarding_pass: boarding_pass) }
  scope :sent_cloud, -> { where(sent_cloud: true) }
  scope :unsent_cloud, -> { where.not(sent_cloud: true) }
  scope :ready_to_send_cloud, -> {
    where(sent_cloud: false)
      .where.not(passport: [nil, ''])
      .where.not(boarding_pass: [nil, ''])
      .where.not(seat: [nil, ''])
      .where.not(check_in_time: [nil, ''])
  }
  scope :inactive, -> {
    unscoped.where(active: false)
  }

  before_update :update_deck

  delegate :id, to: :trip, prefix: true

  def main?
    s = seat.to_s.downcase
    s.start_with?('m') || s.start_with?('v')
  end

  def lower?
    seat.to_s.downcase.start_with?('l')
  end

  def deactivate!
    self.update!(active: false)
  end

  def self.name_map
    Passenger.pluck(:passport, :name).to_h
  end

  private

  def update_deck
    return if seat.nil?
    _deck = main? ? 0 : 1

    self.assign_attributes(deck: _deck)
  end
end
