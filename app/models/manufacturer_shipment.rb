class ManufacturerShipment < ActiveRecord::Base
  belongs_to :order, :class_name => 'Spree::Order'

  def self.change_tracking(order, tracking)
    manufacturer_shipment = self.find_or_initialize_by(order: order)
    manufacturer_shipment.tracking = tracking
    manufacturer_shipment.save
  end
end
