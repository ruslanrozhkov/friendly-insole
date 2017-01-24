class AddSavedLineItemToOrderForms < ActiveRecord::Migration
  def change
    add_reference :order_forms, :saved_line_item
  end
end
