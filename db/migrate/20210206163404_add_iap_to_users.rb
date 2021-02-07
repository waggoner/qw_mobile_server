class AddIapToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_subscribed, :boolean, default: false
    add_column :users, :expires_at, :datetime
    add_column :users, :receipt_verification, :text
  end
end
