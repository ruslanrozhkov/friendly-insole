Deface::Override.new(:virtual_path => "spree/shared/_order_details",
                     :name => "remove-price-totals-from-order-details-for-manufacturer",
                     :surround => "tfoot") do
  '<% unless @is_manufacturer %>
      <%= render_original %>
  <% end %>'
end