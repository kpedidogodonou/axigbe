defmodule Axigbe.Market.ProductCategory do
  use Ash.Resource,
  domain: Axigbe.Market,
  data_layer: AshPostgres.DataLayer

  postgres do
    table "product_categories"
    repo Axigbe.Repo
  end

  actions do
    defaults [:read, :update, :destroy]

    create :create do
      accept [:name]
    end


    read :by_id do
      argument :id, :uuid, allow_nil?: false
      get? true
      filter expr(id == ^arg(:id))
    end


    read :by_name do
      argument :name, :string, allow_nil?: false
      get? true
      filter expr(name == ^arg(:name))
    end

  end

  identities do
    identity :unique_product_category, [:name]
  end



  attributes do
    uuid_primary_key :id
    attribute :name, :string, allow_nil?: false

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end
 

end
