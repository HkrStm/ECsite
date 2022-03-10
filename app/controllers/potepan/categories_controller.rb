class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.includes(:root)
    @taxon_products = Spree::Product.in_taxons(@taxon).includes(master: [:default_price, images: [attachment_attachment: :blob]])
  end
end
