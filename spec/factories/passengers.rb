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
FactoryBot.define do
  factory :passenger do
    name { Faker::Name.unique.name }
    boarding_pass { Faker::Number.unique.number(digits: 10) }
    check_in_time { Time.current.strftime("%Y-%m-%d %H:%M")}
  end
end
