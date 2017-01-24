Deface::Override.new(:virtual_path => "spree/admin/orders/_shipment",
                     :name => "add-shipping-label-btn-to-admin-shipment",
                     :replace_contents => '[data-hook="stock-location"]',
                     :partial => 'spree/admin/orders/shipment_actions')