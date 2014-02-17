class AddUpToUptimeChecks < ActiveRecord::Migration
  def change
    add_column :uptime_checks, :up, :boolean
  end
end
