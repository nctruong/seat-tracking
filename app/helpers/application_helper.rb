module ApplicationHelper
  def vessels?
    Rails.configuration.common.dig(:deck_template) == 'vessels'
  end
end
