require 'rails_helper'

RSpec.describe "Products", type: :system do
  let(:taxon) { create(:taxon) }
  let(:product) { create(:product, taxons: [taxon]) }
  let(:image) { create(:image) }

  before do
    product.images << image
  end

  scenario "商品詳細ページからカテゴリー一覧へ移動する" do
    visit potepan_product_path(product.id)
    click_on "一覧ページへ戻る"
    expect(current_path).to eq potepan_category_path(product.taxons.first.id)
  end
end
