Deface::Override.new(:virtual_path => "spree/admin/orders/_shipment",
                     :name => "replace-spree-tracking-in-backend",
                     :replace => "erb[loud]:contains('link_to_tracking')") do
  '<span class="tracking-number">
    <%= link_to shipment.tracking, "#" %>
  </span>'
end