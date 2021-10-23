class ChangeFavorites < ActiveRecord::Migration[5.2]
  def change
    change_column_null :favorites, :knowledge_id, false
  end
end
