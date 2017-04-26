class AddStatusToOrderItem < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :status, :string
  end
end
