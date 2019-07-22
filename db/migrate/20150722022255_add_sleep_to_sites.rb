class AddSleepToSites < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :nap, :boolean
    add_column :sites, :bedtime, :string
  end
end
