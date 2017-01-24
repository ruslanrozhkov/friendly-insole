Deface::Override.new(:virtual_path => "spree/admin/orders/index",
                     :name => "add-awaiting-approval-option-to-admin-orders-filter",
                     :insert_after => "[data-hook='admin_orders_index_search'] .checkbox:last-of-type") do
  "<div class='checkbox'>
    <%= label_tag 'q_approver_id_null' do %>
      <%= f.check_box :approver_id_null, {:checked => (params[:q][:approver_id_null] == '1')}, '1', '' %>
      Only Show Orders Awaiting Approval
    <% end %>
  </div>"
end