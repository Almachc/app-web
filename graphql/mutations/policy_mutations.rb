module Graphql
  module PolicyMutations
    def create_policy
      <<-GRAPHQL
        mutation CreatePolicy(
          $vehicle: VehicleInput!,
          $insured: InsuredInput!
        ) {
          createPolicy(
            input: {
              attributes: {
                vehicle: $vehicle,
                insured: $insured
              }
            }
          ) { message }
        }
      GRAPHQL
    end
  end
end
