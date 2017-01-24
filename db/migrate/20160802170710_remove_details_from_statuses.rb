class RemoveDetailsFromStatuses < ActiveRecord::Migration
  def change
    remove_column :statuses, :previous, :string
    remove_column :statuses, :next, :string
  end
end
