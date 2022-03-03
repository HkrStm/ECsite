require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "#show" do
    let(:product) { create(:product) }

    before do
      get potepan_product_path(product.id)
    end

    it "リクエストが成功すること" do
      expect(response).to have_http_status(200)
    end

    it "データを取得できていること" do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
    end
  end
end
