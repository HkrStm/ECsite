class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @related_products = Spree::Product.
      in_taxons(@product.taxons).
      includes(master: [:default_price, images: [attachment_attachment: :blob]]).
      where.not(id: @product.id).
      distinct.
      max(4)
  end
end
