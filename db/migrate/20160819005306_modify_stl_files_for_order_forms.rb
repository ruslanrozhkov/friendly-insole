class ModifyStlFilesForOrderForms < ActiveRecord::Migration
  def self.up
    change_table :order_forms do |t|
      t.attachment :stl_file_l
      t.attachment :stl_file_r
    end

    remove_attachment :order_forms, :stl_file
  end

  def self.down
    remove_attachment :order_forms, :stl_file_l
    remove_attachment :order_forms, :stl_file_r
  end
end
