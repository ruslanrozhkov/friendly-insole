Deface::Override.new(:virtual_path => "spree/products/_cart_form",
                     :name => "reposition-add-to-cart-btn",
                     :set_attributes => "[data-hook='product_price']",
                     :attributes => {:class => 'col-sm-5 col-sm-push-7'})