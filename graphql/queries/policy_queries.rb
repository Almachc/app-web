module Graphql
  module PolicyQueries
    def get_policy
      <<-GRAPHQL
        query GetPolicy($id: ID!) {
          policy(id: $id) {
            effectiveFrom
            effectiveUntil
            insured {
              name
              documentNumber
            }
            vehicle {
              licensePlate
              make
              model
              year
            }
          }
        }
      GRAPHQL
    end

    def get_policies
      <<-GRAPHQL
        query GetPolicies {
          policies {
            id
            effectiveFrom
            effectiveUntil
            insured {
              name
              documentNumber
            }
            vehicle {
              licensePlate
              make
              model
              year
            }
          }
        }
      GRAPHQL
    end
  end
end
