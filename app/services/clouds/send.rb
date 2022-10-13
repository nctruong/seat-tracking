module Cloud
  class Sync < BaseService
    def call
      send_cloud if passengers.any?
    end

    private

    def send_cloud
      mark_sent if response.status == 200
    end

    def response
      @response ||= conn.post(Endpoint::SEAT_TRANS_LOG) { |req| req.body = request.to_json }
    end

    def conn
      @conn ||= Faraday.new(headers: { 'Content-Type' => 'application/json',
                                       'x-api-key' => Rails.configuration.common.dig(:apiKey) })
    end

    def mark_sent
      passengers.update_all(sent_cloud: true)
    end

    def request
      { "SeatData": passengers.map { |passenger| ::PassengerLog.new(passenger).json } }

    end

    def passengers
      @passengers ||= Passenger.ready_to_send_cloud.order(:updated_at)
    end
  end
end