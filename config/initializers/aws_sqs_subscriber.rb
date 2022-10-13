require 'sidekiq/api'

def enqueued?
  Sidekiq::Queue.new(:default).any? do |job|
    'UpdateSeatWorker' == job.klass
  end
end

Rails.application.reloader.to_prepare do
  if ActiveRecord::Base.connection.table_exists? 'trips'
    UpdateSeatWorker.perform_async unless enqueued?
  end
end