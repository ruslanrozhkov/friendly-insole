class CreateManufacturerShipments < ActiveRecord::Migration
  def change
    create_table :manufacturer_shipments do |t|
      t.belongs_to :order
      t.string :tracking

      t.timestamps null: false
    end
  end
end
