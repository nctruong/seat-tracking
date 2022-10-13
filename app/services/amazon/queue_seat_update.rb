module Amazon
  class QueueSeatUpdate < BaseService
    attr_reader :region, :queue_name, :sqs, :processor

    def initialize(processor = UpdateSeat)
      Dotenv::Railtie.load

      @region     = ENV['AWS_REGION']
      @queue_name = Rails.configuration.common.dig(:sqs_queue)
      @sqs        = Aws::SQS::Client.new(region: region)
      @processor  = processor
    end

    def call
      begin
        Aws::SQS::QueuePoller.new(sqs.get_queue_url(queue_name: queue_name).queue_url)
                             .poll({
                                     max_number_of_messages: 10,
                                     # idle_timeout:           60 # Stop polling after 60 seconds of no more messages available (polls indefinitely by default).
                                   }) do |messages|

          messages.each do |message|
            processor.call(message.body)
            # puts message.body
          end
        end
      rescue Aws::SQS::Errors::NonExistentQueue
        puts "Cannot receive messages using Aws::SQS::QueuePoller for a queue named '#{queue_name}', as it does not exist."
      end
    end

  end
end