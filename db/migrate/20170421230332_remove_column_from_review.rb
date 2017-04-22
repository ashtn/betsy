class RemoveColumnFromReview < ActiveRecord::Migration[5.0]
  def change
    remove_column :reviews, :merchant_id, :string
  end
end
