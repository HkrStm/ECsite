require 'rails_helper'

RSpec.describe "Categories", type: :system do
  let(:taxonomy) { create(:taxonomy) }
  let(:root) { taxonomy.root }
  let(:taxon) { create(:taxon, taxonomy: taxonomy, parent: root, name: "taxon") }
  let(:other_taxon) { create(:taxon, taxonomy: taxonomy, parent: root, name: "other_taxon") }
  let(:product) { create(:product, taxons: [taxon]) }
  let(:other_product) { create(:product, taxons: [other_taxon], price: 15) }
  let(:image) { create(:image) }
  let(:other_image) { create(:image) }

  before do
    product.images << image
    other_product.images << other_image
    visit potepan_category_path(taxon.id)
  end

  scenario 'サイドバーを操作し異なるカテゴリーページへ移動する' do
    click_on root.name
    within("ul.side-nav") do
      expect(page).to have_content taxon.name
      expect(page).to have_content taxon.products.count
      expect(page).to have_content other_taxon.name
      expect(page).to have_content other_taxon.products.count
    end
    click_on other_taxon.name
    expect(current_path).to eq potepan_category_path(other_taxon.id)
  end

  it "カテゴリーの商品が表示されること" do
    expect(page).to have_content product.name
    expect(page).to have_content product.display_price
    expect(page).to have_selector("img, [src$='#{image.filename}']")
  end

  it "別のカテゴリーの商品は表示されないこと" do
    expect(page).not_to have_content other_product.name
    expect(page).not_to have_content other_product.display_price
    expect(page).not_to have_no_selector("img, [src$='#{other_image.filename}']")
  end
end
