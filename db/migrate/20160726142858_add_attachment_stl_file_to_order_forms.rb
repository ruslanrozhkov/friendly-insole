class AddAttachmentStlFileToOrderForms < ActiveRecord::Migration
  def self.up
    change_table :order_forms do |t|
      t.attachment :stl_file
    end
  end

  def self.down
    remove_attachment :order_forms, :stl_file
  end
end
