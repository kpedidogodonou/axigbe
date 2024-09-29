defmodule Axigbe.Market.BusinessBusinessSubCategory do
  use Ash.Resource,
  domain: Axigbe.Market,
  data_layer: AshPostgres.DataLayer

  postgres do
    table "business_business_sub_categories"
    repo Axigbe.Repo
  end

  actions do
    defaults [:create, :read, :destroy]
  end

  relationships do
    belongs_to :business, Axigbe.Market.Business do
      primary_key? true
      allow_nil? false
    end

    belongs_to :sub_category, Axigbe.Market.BusinessSubCategory do
      primary_key? true
      allow_nil? false
    end
  end
end
