Deface::Override.new(:virtual_path => "spree/products/_cart_form",
                     :name => "inject-order-form",
                     :insert_before => "div#inside-product-cart-form",
                     :partial => 'shared/order_form_for_frontend')