class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :uid, limit: 255
      t.string :token
      t.string :secret
      t.string :name, limit: 255
      t.string :provider
      t.boolean :connected, default: false

      t.timestamps
    end
  end
end
