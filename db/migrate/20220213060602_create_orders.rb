class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :order_number, index: true
      t.datetime :valid_until
      t.string :currency
      t.decimal :amount
      t.string :payment_type
      t.datetime :paytime
      t.string :state
      t.references :course, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
