defmodule Axigbe.Market.ProductReview do
  use Ash.Resource,
  domain: Axigbe.Market,
  data_layer: AshPostgres.DataLayer

  postgres do
    table "product_reviews"
    repo Axigbe.Repo
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      accept [:comment, :rating, :product_id]
    end

    update :update do

      accept [:comment, :rating, :product_id]
    end

    read :by_id do
      argument :id, :uuid, allow_nil?: false
      get? true
      filter expr(id == ^arg(:id))
    end
  end

  attributes do
    uuid_primary_key :id
    attribute :comment, :string, allow_nil?: false
    attribute :rating, :integer do
      allow_nil? false
      constraints [
        min: 0,
        max: 5
      ]

    end

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :product, Axigbe.Market.Product do
      attribute_writable? true
      allow_nil? false
    end
  end

end
