module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :seat

    def connect
      @seat = 'PassengerList'
    end
  end
end
