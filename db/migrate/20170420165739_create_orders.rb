class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :session_id
      t.string :status
      t.float :total

      t.timestamps
    end
  end
end
