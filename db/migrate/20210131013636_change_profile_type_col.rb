class ChangeProfileTypeCol < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :profile_type, :string
  end
end
