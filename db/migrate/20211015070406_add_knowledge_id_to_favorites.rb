class AddKnowledgeIdToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :knowledge_id, :integer
  end
end
