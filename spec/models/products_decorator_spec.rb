require 'rails_helper'

RSpec.describe Spree::ProductDecorator, type: :model do
  describe "#related_products" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon)    { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
    let(:product)  { create(:product, taxons: [taxon]) }

    context "関連商品が4つの場合" do
      let(:related_taxonomy)  { create(:taxonomy) }
      let(:related_taxon)     { create(:taxon, taxonomy: related_taxonomy, parent: related_taxonomy.root) }
      let(:other_taxon)       { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
      let!(:related_products) { create_list(:product, 4, taxons: [taxon, related_taxon]) }
      let(:other_product)     { create(:product, taxons: [other_taxon]) }

      it "関連商品のデータが含まれること" do
        expect(product.related_products).to include related_products[0]
      end

      it "関連した商品以外のデータは含まれないこと" do
        expect(product.related_products).not_to include other_product
      end

      it "取得したデータに重複のないこと" do
        expect(product.related_products).to match_array related_products.uniq
      end

      it "関連商品のデータを4つ取得すること" do
        expect(product.related_products.count).to eq 4
      end
    end

    context "関連商品が5つの場合" do
      let!(:related_products) { create_list(:product, 5, taxons: [taxon]) }

      it "関連商品のデータを5つ以上取得しないこと" do
        expect(product.related_products.count).to eq 4
      end
    end
  end
end
