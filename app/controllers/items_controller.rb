class ItemsController < ApplicationController
  def index
    @category = Category.find_by(params[:category_id])
    @items = @category.items.all?
  end

  def show
    @category = Category.find_by(params[:category_id])
    @item = @category.items.find_by(params[:id])
  end

  def all_items
    @items = Items.all
  end
end
