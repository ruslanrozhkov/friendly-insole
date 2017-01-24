Deface::Override.new(:virtual_path => "spree/products/show",
                     :name => "remove-taxons-from-products",
                     :remove => "erb[loud]:contains('taxons')")