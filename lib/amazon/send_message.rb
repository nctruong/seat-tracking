# SAMPLE FROM AWS - for testing in console
module Amazon
  class SendMessage < BaseService
    def call
      Dotenv::Railtie.load
      region     = 'ap-southeast-1'
      queue_name = 'batamfast-seat'
      message_body = 'This is my message.'

      sts_client = Aws::STS::Client.new(region: region)

      # For example:
      # 'https://sqs.us-east-1.amazonaws.com/111111111111/my-queue'
      queue_url = 'https://sqs.' + region + '.amazonaws.com/' +
        sts_client.get_caller_identity.account + '/' + queue_name

      sqs_client = Aws::SQS::Client.new(region: region)

      puts "Sending a message to the queue named '#{queue_name}'..."

      if message_sent?(sqs_client, queue_url, message_body)
        puts 'Message sent.'
      else
        puts 'Message not sent.'
      end
    end

    def message_sent?(sqs_client, queue_url, message_body)
      sqs_client.send_message(
        queue_url:    queue_url,
        message_body: message_body
      )
      true
    rescue StandardError => e
      puts "Error sending message: #{e.message}"
      false
    end
  end
end