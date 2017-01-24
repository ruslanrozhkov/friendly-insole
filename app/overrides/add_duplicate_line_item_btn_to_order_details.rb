Deface::Override.new(:virtual_path => "spree/shared/_order_details",
                     :name => "add-duplicate-line-item-btn-to-order-details",
                     :insert_bottom => "[data-hook='order_item_total']") do
  '<% if @order.state != "confirm" and !order_just_completed?(@order) and !@is_manufacturer %>
      <a href="#" data-item-id="<%= item.id %>" class="duplicate-item"><i class="glyphicon glyphicon-duplicate"></i></a>
   <% end %>'
end