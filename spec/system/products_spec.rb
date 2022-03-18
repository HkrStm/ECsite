require 'rails_helper'

RSpec.describe "Products", type: :system do
  let(:taxonomy)               { create(:taxonomy) }
  let(:root)                   { taxonomy.root }
  let(:taxon)                  { create(:taxon, taxonomy: taxonomy, parent: root) }
  let(:other_taxon)            { create(:taxon, taxonomy: taxonomy, parent: root) }
  let(:product)                { create(:product, taxons: [taxon], price: 10) }
  let(:other_product)          { create(:product, taxons: [other_taxon], price: 15) }
  let(:related_products)       { create(:product, taxons: [taxon]) }
  let(:image)                  { create(:image) }
  let(:other_product_image)    { create(:image) }
  let(:related_products_image) { create(:image) }

  before do
    product.images       << image
    other_product.images << other_product_image
    related_products.images << related_products_image
    visit potepan_product_path(product.id)
  end

  describe "商品詳細" do
    scenario "商品詳細ページからカテゴリー一覧へ移動する" do
      click_on "一覧ページへ戻る"
      expect(current_path).to eq potepan_category_path(product.taxons.first.id)
    end

    it "商品の詳細が表示されること" do
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
      expect(page).to have_content product.description
      expect(page).to have_selector("img, [src$='#{image.filename}']")
    end
  end

  describe "関連商品" do
    scenario "関連商品をクリックしてその商品詳細ページへ移動する" do
      click_on related_products.name
      expect(current_path).to eq potepan_product_path(related_products.id)
    end

    it "関連商品が表示されること" do
      expect(page).to have_content related_products.name
      expect(page).to have_content related_products.display_price
      expect(page).to have_selector("img, [src$='#{related_products_image.filename}']")
    end

    it "関連商品以外は表示されないこと" do
      expect(page).not_to have_content other_product.name
      expect(page).not_to have_content other_product.display_price
    end

    it "商品詳細に表示されている商品が関連商品に表示されないこと" do
      within '.productBox' do
        expect(page).not_to have_content product.name
        expect(page).not_to have_content product.display_price
      end
    end

    xit "関連商品が最大4つ表示されること" do
    end
  end
end
