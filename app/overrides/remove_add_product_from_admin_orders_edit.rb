Deface::Override.new(:virtual_path => "spree/admin/orders/edit",
                     :name => "remove-add-product-from-shipments-admin",
                     :remove => "erb[loud]:contains('add_product')")