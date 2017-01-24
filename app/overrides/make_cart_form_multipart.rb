Deface::Override.new(:virtual_path => "spree/products/_cart_form",
                     :name => "make-cart-form-multipart",
                     :replace => "erb[loud]:contains('form_for :order')",) do
  "<%= form_for :order, :url => populate_orders_path, :html => { :multipart => true } do |f| %>"
end