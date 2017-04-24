class AddMerchantIdToOrderItems < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :merchant_id, :integer, index: true, foreign_key: true
  end
end
