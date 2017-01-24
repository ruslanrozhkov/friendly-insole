Deface::Override.new(:virtual_path => "spree/products/show",
                     :name => "remove-details-from-products",
                     :remove => "erb[loud]:contains('properties')")