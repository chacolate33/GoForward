class RemovePhraseIdFromFavorites < ActiveRecord::Migration[5.2]
  def change
    remove_column :favorites, :phrase_id, :integer
  end
end
