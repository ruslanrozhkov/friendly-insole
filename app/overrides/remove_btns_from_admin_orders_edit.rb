Deface::Override.new(:virtual_path => "spree/admin/orders/_shipment_manifest",
                     :name => "remove-btns-from-shipments-admin",
                     :replace_contents => "td[data-hook='cart_item_delete']",
                     :text => '')