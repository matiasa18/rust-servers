class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :server_id
      t.string :ip
      
      t.timestamps
    end
    add_index :votes, :server_id
  end
end
