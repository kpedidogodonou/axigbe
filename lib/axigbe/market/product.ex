# defmodule Axigbe.Market.Product do
#   use Ash.Resource,
#   domain: Axigbe.Market,
#   data_layer: AshPostgres.DataLayer

# postgres do
#   table "products"
#   repo Axigbe.Repo
# end

# actions do
#   defaults [:read, :destroy]

#   create :create do

#     accept [:title]
#   end

#   update :update do

#     accept [:content]
#   end

#   read :by_id do
#     argument :id, :uuid, allow_nil?: false
#     get? true
#     filter expr(id == ^arg(:id))
#   end
# end

# attributes do
#   uuid_primary_key :id
#   attribute :name, :string, allow_nil?: false
#   attribute :description, :string, allow_nil?: false
#   attribute :is_service?, :boolean, default: false, allow_nil?: false

#   create_timestamp
#   update_timestamp
# end

# relationships do
#   belongs_to :owner, Axigbe.Accounts.User
#   has_many :reviews, Axigbe.Market.BusinessReview
# end
# end
