class CartController < ApplicationController
  before_action :cart_items
  respond_to :js

  def show
    if @cart_items
      items = JSON.parse(@cart_items)
      @items = []

      items.each do |k,v|
        item = Item.find_by(id: k)
        item.define_singleton_method(:quantity) do
          v
        end
        @items << item
      end
      @total_cost = total_cost(@items)
    end
  end

  def add_item
    if !@cart_items
      @items = { params[:id] => params[:item][:quantity] }

    else
      @items = JSON.parse(@cart_items)
      @items[params[:id]] = params[:item][:quantity]
    end
    @item = Item.find(params[:id])
    flash.now[:success] = "#{@item.title} have been added to cart"
    cookies.permanent.encrypted.signed[:cart] = JSON.generate(@items)
  end

  def update_item
    @items = JSON.parse(@cart_items)
    @items[params[:id]] = params[:item][:quantity]
    cookies.permanent.encrypted.signed[:cart] = JSON.generate(@items)
    @item = Item.find(params[:id])
    @quantity = params[:item][:quantity].to_i
    flash.now[:success] = "#{@item.title} quantity have been updated"
  end

  def remove_item
    items = JSON.parse(@cart_items)
    items.delete(params[:id])

    # if only one item in cart, delete the entire cart, else regenerate the cookies content

    if items.empty?
      cookies.delete(:cart)
    else
      cookies.permanent.encrypted.signed[:cart] = JSON.generate(items)
    end

    @item = Item.find(params[:id])
    flash.now[:danger] = "#{@item.title} has been removed from cart"
  end

  def total_cost(items)
    total_cost = 0
    items.each do |item|
      item_cost = item.price * item.quantity.to_i
      total_cost += item_cost
    end
    total_cost
  end

  private

  def quantity
    params[item][quantity]
  end

  def cart_items
    @cart_items = cookies.permanent.encrypted.signed[:cart]
  end
end
