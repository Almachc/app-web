require_relative './queries/policy_queries'
require_relative './mutations/policy_mutations'

module Graphql
  class Operations
    class << self
      include PolicyQueries
      include PolicyMutations
    end
  end
end
