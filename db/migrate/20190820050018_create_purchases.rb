class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.float :product_price
      t.float :product_discount
      t.string :address
      t.string :telephone

      t.timestamps
    end
  end
end
