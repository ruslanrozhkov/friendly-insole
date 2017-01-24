Deface::Override.new(:virtual_path => "spree/admin/orders/_line_items",
                     :name => "inject-order-form-for-admin-cart",
                     :insert_after => "tr.line-item",
                     :partial => "shared/order_form_for_backend_line_items")