class CheckoutController < ApplicationController
  before_action :cart_items, :check_payment_status, :authenticate_user!

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
      create_order(result.transaction.id)
      redirect_to checkout_path(result.transaction.id)
      # @items.each {|item| order.ordered_items.create(item_id: item.id)}


      flash[:success] = "We have received your payment and will be shipping shortly"
      redirect_to root_path
    else
      flash[:danger] = "We have some issues placing your order. Please try again."
      redirect_to new_checkout_path
    end
  end

  def show
    # get orders
    @transaction_id = params[:id]
    @order = Order.find_by(transaction_id: @transaction_id)
    @ordered_items = @order.ordered_items
  end

  def current_user_orders
    @orders = Order.where(user_id: current_user.id).order(id: :asc)
  end

  def create_order(transaction_id)
    if @payment_status
      payment = JSON.parse(@payment_status)
      payment["transaction_id"] = transaction_id
    else
      payment = { transaction_id: transaction_id }
    end

    cookies.permanent.encrypted.signed[:payment] = JSON.generate(payment)

    # create order
    @order = Order.new
    @order.transaction_id = transaction_id
    @order.total_cost = @total_cost
    @order.user_id = current_user.id

    if @order.save

    # create ordered items
      if @cart_items
        items = JSON.parse(@cart_items)
        items.each do |item_id, quantity|
          @oi = OrderedItem.new
          @oi.order_id = @order.id
          @oi.item_id = item_id
          @oi.quantity = quantity
          @oi.save
        end
        cookies.delete(:cart)
      end
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

  def check_payment_status
    @payment_status = cookies.permanent.encrypted.signed[:payment]
  end
end
