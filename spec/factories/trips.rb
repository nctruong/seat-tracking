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
FactoryBot.define do
  factory :trip do
    trip_id { "221212BTCTMF#{Faker::Number.number(digits: 4)}" }
    depart_date { Date.current.strftime("%Y-%m-%d") }
    etd { '09:20' }
    eta { '11:00' }
    vessel_id { 'AR2' }
    vessel_name { Faker::Games::Dota.hero }
    port_origin_id { "BTC" }
    port_origin_name { "Batam Center" }
    port_destination_id { "TMF" }
    port_destination_name { "TanahMerah" }
    port_origin_country { "INDONESIA" }
    port_destination_country { "SINGAPORE" }
  end
end
