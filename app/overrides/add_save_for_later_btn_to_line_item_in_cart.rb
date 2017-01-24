Deface::Override.new(:virtual_path => "spree/orders/_line_item",
                     :name => "add-save-for-later-btn-to-line-item-in-cart",
                     :insert_bottom => '[data-hook="cart_item_quantity"]',
                     :partial => 'shared/save_for_later_btn')