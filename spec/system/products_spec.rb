require 'rails_helper'

RSpec.describe "Products", type: :system do
  let(:taxon)           { create(:taxon) }
  let(:product)         { create(:product, taxons: [taxon]) }
  let(:related_product) { create(:product, taxons: [taxon]) }
  let(:image)           { create(:image) }
  let(:other_image)     { create(:image) }

  before do
    product.images         << image
    related_product.images << other_image
    visit potepan_product_path(product.id)
  end

  scenario "商品詳細ページからカテゴリー一覧へ移動する" do
    click_on "一覧ページへ戻る"
    expect(current_path).to eq potepan_category_path(product.taxons.first.id)
  end

  scenario "関連商品をクリックしてその商品詳細ページへ移動する" do
    click_on related_product.name
    expect(current_path).to eq potepan_product_path(related_product.id)
  end
end
