class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.string :ip

      t.timestamps
    end
    add_index :servers, :user_id
  end
end
