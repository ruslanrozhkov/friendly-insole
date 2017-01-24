class ChangeCurrentDefaultOnStatuses < ActiveRecord::Migration
  def up
    change_column_default(:statuses, :current, nil)
  end
end
