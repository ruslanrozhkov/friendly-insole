Deface::Override.new(:virtual_path => "spree/admin/orders/index",
                     :name => "add-messages-to-admin-orders",
                     :insert_before => "erb[silent]:contains('content_for :page_title')") do
  '<% content_for :sidebar do %>
      <%= render :partial => "shared/messages", :locals => {:messages => @messages} %>
  <% end %>'
end