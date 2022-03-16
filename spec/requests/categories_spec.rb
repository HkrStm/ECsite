require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "#show" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon)    { create(:taxon) }
    let(:product)  { create(:product, taxons: [taxon]) }
    let(:image)    { create(:image) }

    before do
      product.images << image
      get potepan_category_path(taxon.id)
    end

    it "リクエストが成功すること" do
      expect(response).to have_http_status(200)
    end

    it "カテゴリーのデータを取得できること" do
      expect(response.body).to include taxonomy.name
      expect(response.body).to include taxon.name
    end

    it "カテゴリーに属する商品データを取得できること" do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include image.filename
    end
  end
end
