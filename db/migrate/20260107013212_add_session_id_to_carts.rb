class AddSessionIdToCarts < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :session_id, :string
    add_column :carts, :abandoned_at, :datetime
    add_index :carts, :session_id, unique: true
  end
end
