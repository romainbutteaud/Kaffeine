class AddSleepToSites < ActiveRecord::Migration
  def change
    add_column :sites, :nap, :boolean
    add_column :sites, :bedtime, :string
  end
end
