class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :license, limit: 8, null: false
      t.string :vehicle_type, default: 'car'
      t.timestamps null: false
    end
  end
end
