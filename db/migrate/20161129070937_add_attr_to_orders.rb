class AddAttrToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :user_id, :integer
    add_column :orders, :status, :integer
    add_column :orders, :total_cost, :float
    add_column :orders, :transaction_id, :string
  end
end
