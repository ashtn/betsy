class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :name_on_card
      t.string :email
      t.string :phone_num
      t.string :ship_address
      t.string :bill_address
      t.string :card_number
      t.string :expiration_date
      t.string :CCV

      t.timestamps
    end
  end
end
