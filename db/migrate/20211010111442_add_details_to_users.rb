class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_deleted, :boolean, default: false, null: false
    add_column :users, :introduction, :text
    add_column :users, :image_id, :string
  end
end
