Deface::Override.new(:virtual_path => "spree/shared/_order_details",
                     :name => "remove-prices-from-order-details-for-manufacturer",
                     :surround => " [data-hook='order_item_price'],
                                    [data-hook='order_item_qty'],
                                    [data-hook='order_item_total'],
                                    .price,
                                    .qty,
                                    .total") do
  '<% unless @is_manufacturer %>
      <%= render_original %>
  <% end %>'
end