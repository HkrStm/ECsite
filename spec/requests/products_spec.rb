require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "#show" do
    let!(:product) { create(:product) }

    it "正常にレスポンスを返すこと" do
      get potepan_product_path(product.id)
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
end
