class AddAttachmentCsvFileToOrderForms < ActiveRecord::Migration
  def self.up
    change_table :order_forms do |t|
      t.attachment :csv_file
    end
  end

  def self.down
    remove_attachment :order_forms, :csv_file
  end
end
