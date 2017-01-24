Deface::Override.new(:virtual_path => "spree/shared/_order_details",
                     :name => "inject-order-form-in-order-details",
                     :insert_after => "[data-hook='order_details_line_item_row']",
                     :partial => "shared/order_form_for_order_details_line_items")