require_relative './queries/policy_queries'

module Graphql
  class Operations
    class << self
      include PolicyQueries
    end
  end
end
