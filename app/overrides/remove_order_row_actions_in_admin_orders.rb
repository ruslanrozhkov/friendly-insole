Deface::Override.new(:virtual_path => "spree/admin/orders/index",
                     :name => "remove-order-row-actions-in-admin-orders",
                     :remove => '[data-hook="admin_orders_index_header_actions"], [data-hook="admin_orders_index_row_actions"]')