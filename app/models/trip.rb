# == Schema Information
#
# Table name: trips
#
#  id                       :uuid             not null, primary key
#  arrival_date             :string
#  available_seats          :integer
#  capacity_seats           :integer
#  depart_date              :string
#  end_ins_time             :datetime
#  ended                    :boolean          default(FALSE)
#  eta                      :string
#  etd                      :string
#  load_ins_time            :datetime
#  port_destination_country :string
#  port_destination_name    :string
#  port_origin_country      :string
#  port_origin_name         :string
#  vessel_name              :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  load_ins_job_id          :string
#  port_destination_id      :string
#  port_origin_id           :string
#  trip_id                  :string
#  vessel_id                :string
#
class Trip < ApplicationRecord
  has_many :passengers, dependent: :destroy

  scope :count_unconfirmed, -> {
    joins(:passengers).where(ended: false)
                      .group("trips.id")
                      .where(passengers: {confirmed: false})
                      .select("trips.id as id, count(passengers.id) as passenger")
  }

  def end!
    self.update(ended: true)
  end

  def endable?
    !self.ended? && !passengers.exists?(confirmed: false)
  end

  def origin_is_singapore?
    self.port_origin_country == "SINGAPORE"
  end
end
