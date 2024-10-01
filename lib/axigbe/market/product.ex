defmodule Axigbe.Market.Product do
  use Ash.Resource,
  domain: Axigbe.Market,
  data_layer: AshPostgres.DataLayer

postgres do
  table "products"
  repo Axigbe.Repo
end

actions do
  defaults [ :destroy]

  read :read do
    primary? true
    prepare build(load: [:category, :business, :reviews], sort: :name)

  end

  read :keyset do
    argument :name, :string
    argument :budget, :float
    argument :area, :string
    prepare build(load: [:category, :business, :reviews], sort: :name)

    filter expr(contains(name, ^arg(:name)) and price <= ^arg(:budget) and contains(business.addresses.city, ^arg(:area)))
    pagination(keyset?: true)

  end

  create :create do
    accept [ :name, :description, :is_service?, :price, :price_on_demand?, :business_id, :category_id]
  end

  update :update do
    accept [:name, :description, :is_service?, :price, :price_on_demand?, :category_id]
  end

  read :by_id do
    argument :id, :uuid, allow_nil?: false
    get? true
    filter expr(id == ^arg(:id))
  end

  read :search do
    argument :keyword, :string, allow_nil?: false
    argument :budget, :float, allow_nil?: true
    prepare build(load: [:category, :business, :reviews], sort: :name)

    filter expr(contains(name, ^arg(:keyword)) and price <= ^arg(:budget))

    pagination do
      required?(false)
      offset?(true)
      keyset?(true)
      countable(true)
    end
  end
end

attributes do
  uuid_primary_key :id
  attribute :name, :string, allow_nil?: false
  attribute :description, :string, allow_nil?: false
  attribute :is_service?, :boolean, default: false, allow_nil?: false
  attribute :price, AshMoney.Types.Money, allow_nil?: true
  attribute :price_on_demand?, :boolean, default: false, allow_nil?: false
  attribute :images, {:array, :string} do
    constraints min_length: 1
    allow_nil? true
  end

  create_timestamp :inserted_at
  update_timestamp :updated_at
end

relationships do
  belongs_to :business, Axigbe.Market.Business, allow_nil?: false
  has_many :reviews, Axigbe.Market.ProductReview
  belongs_to :category, Axigbe.Market.ProductCategory do
    attribute_writable? true
    allow_nil? false
  end
end
end
