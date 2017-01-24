Deface::Override.new(:virtual_path => "spree/shared/_order_details",
                     :name => "replace-hr-with-br-in-order-details",
                     :replace => "hr") do
  '<br>'
end