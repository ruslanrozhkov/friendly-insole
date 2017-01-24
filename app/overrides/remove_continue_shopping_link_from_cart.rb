Deface::Override.new(:virtual_path => "spree/orders/edit",
                     :name => "remove-continue-shopping-link-from-cart",
                     :replace => 'erb[loud]:contains("Spree.t(:continue_shopping)")') do
  "<%= link_to Spree.t(:create_another_insole), Spree::Product.last %>"
end