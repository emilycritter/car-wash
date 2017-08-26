class AddDiscount < ActiveRecord::Migration
  def change
    add_column :transactions, :discount, :float, {after: :price, default: 0}
  end
end
