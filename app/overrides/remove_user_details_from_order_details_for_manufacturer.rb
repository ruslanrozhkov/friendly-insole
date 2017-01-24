Deface::Override.new(:virtual_path => "spree/shared/_order_details",
                     :name => "remove-user-details-from-order-details-for-manufacturer",
                     :surround => "div.row.steps-data") do
  '<% if @is_user or @is_admin %>
      <%= render_original %>
  <% end %>'
end