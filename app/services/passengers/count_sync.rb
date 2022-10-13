module Passengers
  class CountRecordSynchronized < BaseService
    def call
      to_h(count_by_passport)
    end

    private

    def count_by_passport
      Passenger.group(:passport).select("passport,count(*) as count").where("sent_cloud=true")
    end

    def to_h(relation)
      relation.map { |p| { p.passport => p.count } }.inject(&:merge!) || {}
    end
  end
end
