require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title(page_title)" do
    context "page_titleが空白の場合" do
      it "BIGBAG Storeと表示されること" do
        expect(full_title("")).to eq("BIGBAG Store")
      end
    end

    context "page_titleがnilの場合" do
      it "BIGBAG Storeと表示されること" do
        expect(full_title(nil)).to eq("BIGBAG Store")
      end
    end

    context "page_titleが存在する場合" do
      it "page_title - BIGBAG Storeと表示されること" do
        expect(full_title("test")).to eq("test - BIGBAG Store")
      end
    end
  end
end
