Deface::Override.new(:virtual_path => "spree/shared/_order_details",
                     :name => "inject-manufacturing-details-for-manufacturer-frontend",
                     :insert_before => "[data-hook='order_details']") do
  '<% if !@is_user and !@is_admin and !order_just_completed?(@order) %>
      <%= render :partial => "shared/manufacturing_details", :locals => {:order => @order} %>
  <% end %>'
end