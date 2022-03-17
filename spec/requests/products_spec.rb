require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "#show" do
    let(:taxon)           { create(:taxon) }
    let(:product)         { create(:product, taxons: [taxon]) }
    let(:related_product) { create(:product, taxons: [taxon]) }
    let(:image)           { create(:image) }
    let(:other_image)     { create(:image) }

    before do
      product.images         << image
      related_product.images << other_image
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

    it "関連商品のデータを取得できていること" do
      expect(response.body).to include related_product.name
      expect(response.body).to include related_product.display_price.to_s
      expect(response.body).to include other_image.filename
    end
  end
end
