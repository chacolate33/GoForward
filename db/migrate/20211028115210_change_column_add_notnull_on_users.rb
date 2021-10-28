class ChangeColumnAddNotnullOnUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :is_deleted, false
  end
end
