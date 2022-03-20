require 'rails_helper'

RSpec.describe "Products", type: :system do
  let(:taxonomy)            { create(:taxonomy) }
  let(:taxon)               { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
  let(:other_taxon)         { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
  let(:product)             { create(:product, taxons: [taxon], price: 11) }
  let!(:other_product)      { create(:product, taxons: [other_taxon], price: 15) }
  let(:related_products)    { create_list(:product, 5, taxons: [taxon]) }
  let(:image)               { create(:image) }
  let(:other_product_image) { create(:image) }

  before do
    product.images << image
    related_products.each do |related_product|
      related_product.images << create(:image)
    end
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
      click_on related_products[1].name
      expect(current_path).to eq potepan_product_path(related_products[1].id)
    end

    it "関連商品が表示されること" do
      related_products[0..3].all? do |related_product|
        expect(page).to have_content related_product.name
        expect(page).to have_content related_product.display_price
      end
    end

    it "関連した商品以外は関連商品に表示されないこと" do
      expect(page).not_to have_content other_product.name
      expect(page).not_to have_content other_product.display_price
    end

    it "商品詳細に表示されている商品が関連商品に表示されないこと" do
      within '.productsContent' do
        expect(page).not_to have_content product.name
        expect(page).not_to have_content product.display_price
      end
    end

    it "関連商品が4つ表示されること" do
      within '.productsContent' do
        expect(page.all('.productBox').count).to eq 4
      end
    end

    it "関連商品が５つ以上表示されないこと" do
      expect(page).not_to have_content related_products[4].name
    end
  end
end
