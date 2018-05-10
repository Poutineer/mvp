module V1
  class CartItemsShowSchema < V1::ApplicationSchema
    schema type: Strict::Hash do
      field :fields, type: Strict::Array.of(Strict::String).optional
      field :include, type: Strict::Array.of(Strict::String).optional
    end
  end
end