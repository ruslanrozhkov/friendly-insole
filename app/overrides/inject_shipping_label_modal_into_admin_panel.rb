Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "inject-shipping-label-modal-into-admin-panel",
                     :insert_top => "body.admin") do
  "<%= render :partial => 'modals/shipping_label_modal', :locals => {:shipments => @order.shipments} if @order %>"
end