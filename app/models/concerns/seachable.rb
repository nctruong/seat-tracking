module Seachable
  extend ActiveSupport::Concern

  included do
    include PgSearch::Model

    pg_search_scope :search_by_name, against: :name
  end
end
