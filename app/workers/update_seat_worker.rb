class UpdateSeatWorker
  include Sidekiq::Worker

  def perform
    return if count_jobs > 1

    Amazon::QueueSeatUpdate.call
  end

  private

  def count_jobs
    Sidekiq::Queue.new(:default).filter { |job| 'UpdateSeatWorker' == job.klass }.size
  end
end
