defmodule Axigbe.Market.BusinessSubCategory do
  use Ash.Resource,
  domain: Axigbe.Market,
  data_layer: AshPostgres.DataLayer

  postgres do
    table "business_sub_categories"
    repo Axigbe.Repo
  end

  actions do
    defaults [:update, :destroy]

    read :read do
      primary? true
      prepare build(load: [:businesses])
    end

    create :create do
      primary? true
      accept [:name, :business_category_id]
      argument :businesses, {:array, :map}

      change manage_relationship(:businesses,
               type: :append_and_remove,
               on_no_match: :create
             )
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
    identity :unique_business_sub_category, [:name]
  end

  attributes do
    uuid_primary_key :id
    attribute :name, :string, allow_nil?: false

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    # belongs_to :business, Axigbe.Market.Business, allow_nil?: false
    belongs_to :business_category, Axigbe.Market.BusinessCategory, allow_nil?: false

    many_to_many :businesses, Axigbe.Market.Business do
      through Axigbe.Market.BusinessBusinessSubCategory
      source_attribute_on_join_resource :sub_category_id
      destination_attribute_on_join_resource :business_id
      could_be_related_at_creation? true

    end
  end

end
