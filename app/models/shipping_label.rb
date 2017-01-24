class ShippingLabel < ActiveRecord::Base
  # belongs_to :user, :foreign_key => 'created_by_id', :class_name => 'Spree::User'
  # belongs_to :user, :foreign_key => 'updated_by_id', :class_name => 'Spree::User'
  belongs_to :shipment, :class_name => 'Spree::Shipment'

  belongs_to :created_by, :class_name => 'Spree::User'
  belongs_to :updated_by, :class_name => 'Spree::User'

  has_attached_file :label

  validates_attachment :label, presence: true, content_type: { content_type: 'application/pdf' }
end
