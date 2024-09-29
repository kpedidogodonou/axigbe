defmodule Axigbe.Market.Business do
  use Ash.Resource,
    domain: Axigbe.Market,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "businesses"
    repo Axigbe.Repo
  end

  actions do
    defaults [:destroy]

    read :read do
      primary? true
      # prepare build(load: [:reviews, :products])
    end

    create :create do
      accept [:owner_id, :name_id, :name, :description]
      primary? true
      argument :sub_categories, {:array, :map} do
        constraints min_length: 1
        allow_nil? false
      end

      change manage_relationship(:sub_categories,
      type: :append_and_remove,
      on_no_match: :create
    )
    end

    update :update do

      accept [:name_id, :name, :description]
    end

    read :by_id do
      argument :id, :uuid, allow_nil?: false
      get? true
      filter expr(id == ^arg(:id))
    end

    read :with_details do
      prepare build(load: [:sub_categories])

    end
  end

  attributes do
    uuid_primary_key :id
    attribute :name_id, :string, allow_nil?: false
    attribute :name, :string, allow_nil?: false
    attribute :description, :string, allow_nil?: false
    attribute :avatar, :string, allow_nil?: false, default: "https://gravatar.com/avatar/9474ded9f72bb55143599151b9356a9f?s=400&d=robohash&r=x"
    attribute :banner, :string, allow_nil?: false, default: "https://images.unsplash.com/photo-1726533870778-8be51bf99bb1?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  identities do
    identity :unique_business_name_id, [:name_id]
  end

  relationships do
    belongs_to :owner, Axigbe.Accounts.User, allow_nil?: false
    has_many :products, Axigbe.Market.Product
    has_many :reviews, Axigbe.Market.BusinessReview

    many_to_many :sub_categories, Axigbe.Market.BusinessSubCategory do
      through Axigbe.Market.BusinessBusinessSubCategory
      source_attribute_on_join_resource :business_id
      destination_attribute_on_join_resource :sub_category_id
      could_be_related_at_creation? true
    end

  end
end
