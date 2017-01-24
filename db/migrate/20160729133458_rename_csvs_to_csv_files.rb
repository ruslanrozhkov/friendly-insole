class RenameCsvsToCsvFiles < ActiveRecord::Migration
  def change
    rename_table :csvs, :csv_files
  end
end
