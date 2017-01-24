Deface::Override.new(:virtual_path => "spree/admin/orders/_shipment_manifest",
                     :name => "inject-order-form-for-admin-edit",
                     :insert_after => "tr.stock-item",
                     :partial => "shared/order_form_for_backend_shipments")