class TripDecorator < Draper::Decorator
  delegate_all

  def depart_date_time_str
    "#{depart_date} #{etd} SGT"
  end

  def depart_date_time
    depart_date_time_str.to_datetime
  end

  def estimate_arrived_time
    "#{depart_date} #{eta} SGT".to_datetime
  end

  def load_ins_time_moment
    load_ins_time&.strftime("%Y-%m-%dT%H:%M:%S%z")
  end
end
