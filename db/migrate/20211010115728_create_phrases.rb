class CreatePhrases < ActiveRecord::Migration[5.2]
  def change
    create_table :phrases do |t|
      t.integer :user_id, null: false
      t.integer :group_id, null: false
      t.string :content, null: false
      t.string :japanese, null: false

      t.timestamps
    end
  end
end
