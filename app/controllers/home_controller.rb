class HomeController < ApplicationController
  include ApplicationHelper
  include HomeHelper

  helper_method :deck_color

  def index
    @internet = true
    
    begin
      loading_today_data
    rescue Faraday::ConnectionFailed
      @internet = false
    end

    @facade = ::PaxListFacade.new
  end

  private

  def loading_today_data
    return if TripValidation.today_is_loaded?

    Sidekiq.redis(&:flushdb) # be careful with this command, should run before any sidekiq enqueue.
    Trips::Reset.call
  end
end
