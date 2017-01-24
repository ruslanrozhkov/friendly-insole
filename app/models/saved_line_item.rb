class SavedLineItem < ActiveRecord::Base
  has_one :order_form

  belongs_to :user, :class_name => 'Spree::User'
  belongs_to :variant, :class_name => 'Spree::Variant'

  after_destroy :delete_order_form

  def delete_order_form
    form = OrderForm.find_by_saved_line_item_id(self.id)
    form.destroy if form
  end
end
