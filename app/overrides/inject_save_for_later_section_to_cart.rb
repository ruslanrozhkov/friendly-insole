Deface::Override.new(:virtual_path => "spree/orders/edit",
                     :name => "inject-save-for-later-section-to-cart",
                     :insert_bottom => '[data-hook="cart_container"]') do
  "<div class='clearfix'></div>
<%= render partial: 'shared/save_for_later' %>
"
end