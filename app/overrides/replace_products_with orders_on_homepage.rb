Deface::Override.new(:virtual_path => "spree/home/index",
                     :name => "replace-products-with-orders-on-homepage",
                     :replace => "[data-hook='homepage_products']",
                     :template => '/dashboard')