class FixColumnsInMerchants < ActiveRecord::Migration[5.0]
  def change
    change_column :merchants, :uid, :integer, null: false
    change_column :merchants, :provider, :string, null: false

  end
end
