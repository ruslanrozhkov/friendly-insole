Deface::Override.new(:virtual_path => "spree/products/show",
                     :name => "fix-layout-on-product-details",
                     :surround => "div[data-hook='product_show']") do
  "<div class='row'><%= render_original %></div>"
end