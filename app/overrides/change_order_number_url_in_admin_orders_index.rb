# Deface::Override.new(:virtual_path => "spree/admin/orders/index",
#                      :name => "make-order-number-link-to-cart-for-admin-orders",
#                      :replace => "erb[loud]:contains('order.number')") do
#   "<%= link_to order.number, cart_admin_order_path(order) %>"
# end