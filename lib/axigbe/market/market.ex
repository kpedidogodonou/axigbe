defmodule Axigbe.Market do
  use Ash.Domain

  resources do
    resource Axigbe.Market.Business do
      define :create_business, action: :create
      define :list_businesses, action: :read
      define :list_businesses_details, action: :with_details
      define :update_business, action: :update
      define :delete_business, action: :destroy
      define :get_business, args: [:id], action: :by_id
      define :by_name, get_by: [:name], action: :read
    end

    resource Axigbe.Market.BusinessReview do
      define :create_business_review, action: :create
      define :list_business_reviews, action: :read
      define :update_business_review, action: :update
      define :delete_business_review, action: :destroy
      define :get_business_review, args: [:id], action: :by_id
    end


    resource Axigbe.Market.BusinessAddress do
      define :create_business_address, action: :create
      define :list_business_addresses, action: :read
      define :update_business_address, action: :update
      define :delete_business_address, action: :destroy
      define :get_business_address, args: [:id], action: :by_id
    end

    resource Axigbe.Market.BusinessSubCategory do
      define :create_business_sub_category, action: :create
      define :list_business_sub_categories, action: :read
      define :get_business_sub_category, args: [:id], action: :by_id
      define :get_business_sub_category_by_name, args: [:name], action: :by_name
      define :update_business_sub_category, action: :update
      define :delete_business_sub_category, action: :destroy
    end

    resource Axigbe.Market.BusinessBusinessSubCategory

    resource Axigbe.Market.BusinessCategory do
      define :create_business_category, action: :create
      define :list_business_categories, action: :read
      define :get_business_category, args: [:id], action: :by_id
      define :get_business_category_by_name, args: [:name], action: :by_name
      define :update_business_category, action: :update
      define :delete_business_category, action: :destroy
    end

    resource Axigbe.Market.ProductCategory do
      define :create_product_category, action: :create
      define :list_product_categories, action: :read
      define :get_product_category, args: [:id], action: :by_id
      define :get_product_category_by_name, args: [:name], action: :by_name
      define :update_product_category, action: :update
      define :delete_product_category, action: :destroy
    end

    resource Axigbe.Market.Product do
      define :create_product, action: :create
      define :list_products, action: :read
      define :update_product, action: :update
      define :delete_product, action: :destroy
      define :get_product, args: [:id], action: :by_id
      # define :search_products, args: [:keyword, :budget], action: :search
      define :search_products_with_keyset, args: [:name, :budget, :area], action: :keyset

    end

    resource Axigbe.Market.ProductReview do
      define :create_product_review, action: :create
      define :list_product_reviews, action: :read
      define :update_product_review, action: :update
      define :delete_product_review, action: :destroy
      define :get_product_review, args: [:id], action: :by_id
    end


  end


  def search_products(params) do
    Axigbe.Market.search_products_with_keyset!(Map.get(params, :name),  Map.get(params, :budget), Map.get(params, :area), page: [limit: 2, count: true])
  end
end
