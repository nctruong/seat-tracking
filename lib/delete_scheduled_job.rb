class DeleteScheduledJob < BaseService
  attr_reader :jid

  def initialize(jid)
    @jid = jid
  end

  def call
    Sidekiq::ScheduledSet.new.each do |job|
      # job.klass # => 'MyWorker'
      # job.args # => [1, 2, 3]
      job.delete if job.jid == jid
    end
  end
end
