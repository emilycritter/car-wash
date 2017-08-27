class AddConfirmationCode < ActiveRecord::Migration
  def change
    add_column :transactions, :confirmation, :string, {after: :id}
  end
end
