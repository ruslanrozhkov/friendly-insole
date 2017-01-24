Deface::Override.new(:virtual_path => "spree/admin/shared/_order_tabs",
                     :name => "add-messaging-to-admin-order-details",
                     :insert_before => "[data-hook='admin_order_tabs']") do
  '
<ul id="messagesTabs" class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active"><a href="#client" aria-controls="client" role="tab" data-toggle="tab">Client</a></li>
    <li role="presentation"><a href="#manufacturer" aria-controls="manufacturer" role="tab" data-toggle="tab">Manufacturer</a></li>
  </ul>
<br>
<div class="tab-content">
<div role="tabpanel" class="tab-pane active" id="client">
<%= render :partial => "shared/messaging", :locals => {:order => @order, :intended_for => "user"} %>
</div>
<div role="tabpanel" class="tab-pane" id="manufacturer">
<%= render :partial => "shared/messaging", :locals => {:order => @order, :intended_for => "manufacturer"} %>
</div>
   <br><hr><br>'
end