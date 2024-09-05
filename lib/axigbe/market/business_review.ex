# defmodule Axigbe.Market.BusinessReview do
#   use Ash.Resource,
#   domain: Axigbe.Market,
#   data_layer: AshPostgres.DataLayer

#   postgres do
#     table "business_reviews"
#     repo Axigbe.Repo
#   end

#   actions do
#     defaults [:read, :destroy]

#     create :create do

#       accept [:title]
#     end

#     update :update do

#       accept [:content]
#     end

#     read :by_id do
#       argument :id, :uuid, allow_nil?: false
#       get? true
#       filter expr(id == ^arg(:id))
#     end
#   end

#   attributes do
#     uuid_primary_key :id
#     attribute :description, :string, allow_nil?: false
#     attribute :rating, :integer do
#       allow_nil? false
#       constaints [
#         min: 0,
#         max: 5
#       ]

#     end

#     create_timestamp
#     update_timestamp
#   end

#   relationships do
#     belongs_to :business, Axigbe.Market.Business
#   end

# end
