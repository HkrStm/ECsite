module Spree::ProductDecorator
  LIMIT_OF_RELATED_PRODUCTS = 4

  def related_products
    Spree::Product.
      in_taxons(taxons).
      where.not(id: id).
      distinct.
      limit(LIMIT_OF_RELATED_PRODUCTS)
  end

  Spree::Product.prepend self
end
