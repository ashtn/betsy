class AddOrderIdToPayment < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :order_id, :integer
  end
end
