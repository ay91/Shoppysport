class AddAttrToOrderedItems < ActiveRecord::Migration[5.0]
  def change
    add_column :ordered_items, :item_id, :integer
    add_column :ordered_items, :order_id, :integer
    add_column :ordered_items, :quantity, :integer
  end
end
