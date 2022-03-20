require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "#show" do
    let(:taxonomy)          { create(:taxonomy) }
    let(:taxon)             { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
    let(:other_taxon)       { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
    let(:product)           { create(:product, taxons: [taxon]) }
    let!(:other_product)    { create(:product, taxons: [other_taxon]) }
    let!(:related_products) { create_list(:product, 5, taxons: [taxon]) }
    let(:image)             { create(:image) }

    before do
      product.images << image
      related_products.each do |related_product|
        related_product.images << create(:image)
      end
      get potepan_product_path(product.id)
    end

    it "リクエストが成功すること" do
      expect(response).to have_http_status(200)
    end

    it "商品のデータを取得できていること" do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
      expect(response.body).to include image.filename
    end

    it "関連した商品以外のデータは取得されないこと" do
      expect(response.body).not_to include other_product.name
    end

    it "関連商品のデータを4つ取得できていること" do
      related_products[0..3].all? do |related_product|
        expect(response.body).to include related_product.name
        expect(response.body).to include related_product.display_price.to_s
        related_product.images { |image| expect(response.body).to include image.attachment(:product) }
      end
    end

    it "関連商品のデータを5つ以上取得されないこと" do
      expect(response.body).not_to include related_products[4].name
    end
  end
end
