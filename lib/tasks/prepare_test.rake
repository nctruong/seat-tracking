task create_passenger: :environment do
  passengers = []
  Passenger.delete_all
  65.times do
    passengers << {
      deck: :main,

      trip_no: "TDI#{Faker::Number.number(digits: 4)}",
      name: Faker::Name.name,
      confirmed: false,
      passport: Faker::Number.number(digits: 10),
      phone: Faker::PhoneNumber.cell_phone,
      boarding_pass: "C#{Faker::Number.number(digits: 8)}"
    }
  end

  84.times do
    passengers << {
      deck: :lower,

      trip_no: "TDI#{Faker::Number.number(digits: 4)}",
      name: Faker::Name.name,
      confirmed: false,
      passport: Faker::Number.number(digits: 10),
      phone: Faker::PhoneNumber.cell_phone,
      boarding_pass: "C#{Faker::Number.number(digits: 8)}"
    }
  end

  Passenger.create(passengers)
end

task passenger_history_test_data: :environment do
  CleanData.new.perform

  Trips::Create.call
  trips = Trip.last(2)
  Trip.where.not(id: trips.map(&:id)).delete_all
  trips.each do |trip|
    Passengers::Pull.call(trip)
  end
end

task make_data_ready_to_sync: :environment do
  Passenger.update_all(seat: 'V1',
                       check_in_time: Time.current.strftime("%Y-%m-%d %H:%M"))
  Passenger.where(boarding_pass: [nil,'']).update_all(boarding_pass: 'READY')
end

task justify_trip_datetime: :environment do
  Trip.all.update_all(depart_date: '2022-03-17')
  Trip.first.update(etd: '13:00', eta: '14:00')
  Trip.last.update(etd: '14:00', eta: '15:00')
end

task keep_one_pax: :environment do
  trip = Trip.find_by(trip_id: '220318BTCTMF0920')
  trip.passengers.where.not(id: trip.passengers.first.id).destroy_all
end