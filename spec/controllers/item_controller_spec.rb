require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  before(:all) do
    @category = create(:category)
    5.times{create(:item, :sequenced_title, :sequenced_price, :sequenced_description, :with_image, category_id: @category.id)}
  end

  describe "GET#index" do
    it "render item index" do
      params = { category_id: @category.id }
      get :index, params: params
      expect(subject).to render_template(:index)
    end
  end

  describe "GET#show" do
    it "should show item" do
      @item = Item.first
      params = { category_id: @category.id, id: @item.id }
      get :show, params: params
      expect(subject).to render_template(:show)
    end
  end

  describe "GET#all_items" do
    it "should render all items" do
      params = { category_id: @category.id }
      get :all_items, params: params
      expect(subject).to render_template(:all_items)
    end
  end
end
