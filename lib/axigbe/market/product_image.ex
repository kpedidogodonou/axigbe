# defmodule Axigbe.Market.ProductImage do
#   use Ash.Resource,
#   domain: Axigbe.Market,
#   data_layer: AshPostgres.DataLayer

#   postgres do
#     table "product_images"
#     repo Axigbe.Repo
#   end

#   actions do
#     defaults [:read, :update, :destroy]

#     create :create do
#       accept [:url]
#     end


#     read :by_id do
#       argument :id, :uuid, allow_nil?: false
#       get? true
#       filter expr(id == ^arg(:id))
#     end




#   end




#   attributes do
#     uuid_primary_key :id
#     attribute :url, :string, allow_nil?: false
#     belongs_to :product, Axigbe.Market.BusinessCategory, allow_nil?: false

#     create_timestamp :inserted_at
#     update_timestamp :updated_at
#   end


# end
