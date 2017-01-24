Deface::Override.new(:virtual_path => "spree/orders/_line_item",
                     :name => "add-patient-id-to-line-item-in-cart",
                     :insert_bottom => '[data-hook="cart_item_description"]') do
  '<p>Patient Id: <b><%= line_item.order_form.patient_id if line_item.order_form %></b></p>'
end