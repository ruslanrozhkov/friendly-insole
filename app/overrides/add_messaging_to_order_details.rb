Deface::Override.new(:virtual_path => "spree/orders/show",
                     :name => "add-messaging-to-order-details",
                     :surround => "#order") do
  '<% if order_just_completed?(@order) %>
      <%= render_original %>
  <% else %>
      <div class="row">
        <div class="col-md-8">
          <%= render_original %>
        </div>
        <div class="col-md-4">
          <h4>Messages</h4>
          <%= render :partial => "shared/messaging", :locals => {:order => @order, :intended_for => "admin"} %>
        </div>
      </div>
  <% end %>'
end