class CreateUptimeChecks < ActiveRecord::Migration
  def change
    create_table :uptime_checks do |t|
      t.integer :server_id

      t.timestamps
    end
    add_index :uptime_checks, :server_id
  end
end
