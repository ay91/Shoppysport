class CheckoutController < ApplicationController
  before_action :cart_items, :authenticate_user!

  def new
    @token = Braintree::ClientToken.generate
  end

  def create
    result = Braintree::Transaction.sale(
      amount: @total_cost,
      payment_method_nonce: params[:payment_method_nonce],
      options: {
        submit_for_settlement: true
      }
    )

    if result.success?
      order = Order.create do
        transaction_id = result.transaction.id
        amount = result.transaction.amount
        user_id = current_user.id
        status = "pending"
      end
      @items.each {|item| order.ordered_items.create(item_id: item.id)}
      cookies.delete(:cart)

      flash[:success] = "We have received your payment and will be shipping shortly"
      redirect_to root_path
    else
      flash[:danger] = "We have some issues placing your order. Please try again."
      redirect_to new_checkout_path
    end
  end

  private

  def cart_items
    @cart_items = cookies.permanent.encrypted.signed[:cart]
    if @cart_items
      items = JSON.parse(@cart_items)
      @total_cost = 0
      @items = []

      items.each do |k,v|
        item = Item.find_by(id: k)
        item.define_singleton_method(:quantity) do
          v
        end
        @total_cost += item.price * v.to_i
        @items << item
      end
    end
  end
end
