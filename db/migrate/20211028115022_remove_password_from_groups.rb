class RemovePasswordFromGroups < ActiveRecord::Migration[5.2]
  def change
    remove_column :groups, :password, :string
  end
end
