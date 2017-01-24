class RemoveDetailsFromOrderForms < ActiveRecord::Migration
  def change
    remove_column :order_forms, :svl_file, :string
    remove_column :order_forms, :csv_file, :string
  end
end
