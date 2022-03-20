class Potepan::ProductsController < ApplicationController
  LIMIT_OF_RELATED_PRODUCTS = 4

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.
      related_products.
      includes(master: [:default_price, images: [attachment_attachment: :blob]]).
      limit(LIMIT_OF_RELATED_PRODUCTS)
  end
end
