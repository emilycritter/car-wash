class AddConfirmationCode < ActiveRecord::Migration
  def change
    add_column :transactions, :confirmation, :string, {after: :id, unique: true}
  end
end
