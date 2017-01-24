Deface::Override.new(:virtual_path => "spree/admin/orders/_form",
                     :name => "inject-manufacturing-details-to-admin-orders-edit",
                     :insert_before => 'erb[silent]:contains("if Spree::Order.checkout_step_names.include?(:delivery)")') do
  '<% if order.approved? %>
<%= render :partial => "spree/admin/orders/manufacturing_details", :locals => {
        :order => order,
        :title => Spree.t(:manufacturing_details)
   } %>
<% end %>'
end