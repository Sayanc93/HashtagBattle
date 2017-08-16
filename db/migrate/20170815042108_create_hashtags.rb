class CreateHashtags < ActiveRecord::Migration[5.1]
  def change
    create_table :hashtags do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.integer :count, default: 0

      t.timestamps
    end
    add_index :hashtags, [:name, :user_id], unique: true
  end
end
