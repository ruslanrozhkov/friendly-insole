Deface::Override.new(:virtual_path => "spree/products/show",
                     :name => "reposition-price",
                     :insert_bottom => "div#product-description .product-title") do
  ' <small class="price selling"><%= display_price(@product) %> <span itemprop="priceCurrency" content="<%= @product.currency %>"></span> <% if @product.variants.empty? %><span class="text-danger"><%= Spree.t(:out_of_stock) %></span><% end %></small>'
end