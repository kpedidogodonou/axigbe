defmodule Axigbe.Market.BusinessAddress do
  use Ash.Resource,
  domain: Axigbe.Market,
  data_layer: AshPostgres.DataLayer

  import AshGeo.Postgis

  postgres do
    table "business_addresses"
    repo Axigbe.Repo
  end

  actions do
    defaults [:read, :destroy]

    create :create do

      accept [:country, :department, :commune, :city, :arrondissement, :neighbourhood, :location_description, :long, :lat, :business_id]
    end

    update :update do

      accept [:country, :department, :commune, :city, :arrondissement, :neighbourhood, :location_description, :long, :lat, :business_id]
    end

    read :by_id do
      argument :id, :uuid, allow_nil?: false
      get? true
      filter expr(id == ^arg(:id))
    end
  end

  attributes do
    uuid_primary_key :id
    attribute :country, :string, allow_nil?: false
    attribute :department, :string, allow_nil?: false
    attribute :commune, :string, allow_nil?: false
    attribute :city, :string, allow_nil?: false
    attribute :arrondissement, :string, allow_nil?: false
    attribute :neighbourhood, :string, allow_nil?: false
    attribute :location_description, :string, allow_nil?: false
    attribute :long, :float, allow_nil?: true
    attribute :lat, :float, allow_nil?: true
    # attribute :type, :string, default: "primary" , allow_nil?: true


    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :business, Axigbe.Market.Business do
      attribute_writable? true
      allow_nil? true
    end
  end

end
