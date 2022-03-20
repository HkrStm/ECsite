require 'rails_helper'

RSpec.describe Spree::ProductDecorator, type: :model do
  describe "#related_products" do
    let(:taxonomy)          { create(:taxonomy) }
    let(:related_taxonomy)  { create(:taxonomy) }
    let(:taxon)             { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
    let(:other_taxon)       { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
    let(:related_taxon)     { create(:taxon, taxonomy: related_taxonomy, parent: related_taxonomy.root) }
    let(:product)           { create(:product, taxons: [taxon]) }
    let(:other_product)     { create(:product, taxons: [other_taxon]) }
    let!(:related_products) { create_list(:product, 2, taxons: [taxon, related_taxon]) }

    it "関連商品のデータが含まれること" do
      expect(product.related_products).to include related_products[0]
      expect(product.related_products).to include related_products[1]
    end

    it "関連した商品以外のデータは含まれないこと" do
      expect(product.related_products).not_to include other_product
    end

    it "取得したデータに重複のないこと" do
      expect(product.related_products).to match_array related_products.uniq
    end
  end
end
