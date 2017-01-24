class CreateShippingLabels < ActiveRecord::Migration
  def change
    create_table :shipping_labels do |t|
      t.belongs_to :shipment, index: true
      t.attachment :label
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps null: false
    end
  end
end
