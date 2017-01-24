Deface::Override.new(:virtual_path => "spree/orders/show",
                     :name => "remove-back-to-store-link-from-order-details",
                     :remove => "erb[loud]:contains('back_to_store')")