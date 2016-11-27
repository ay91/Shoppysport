class ItemsController < ApplicationController

  def index
    @category = Category.find_by(id: params[:category_id])
    @items = @category.items.all
  end

  def show
    @category = Category.find_by(id: params[:category_id])
    @item = @category.items.find(params[:id])
  end

  def all_items
    @items = Item.all
  end
end
