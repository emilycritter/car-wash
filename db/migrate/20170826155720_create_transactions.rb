class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :customer_id
      t.integer :price, default: 0
      t.boolean :mud, default: false
      t.boolean :bed_down, default: false
      t.timestamps null: false
    end
  end
end
