Deface::Override.new(:virtual_path => "spree/checkout/_confirm",
                     :name => "add-messages-to-checkout-confirm",
                     :insert_top => "[data-hook='buttons']") do
  '<span class="alert alert-warning alert-inline">
<i class="glyphicon glyphicon-info-sign"></i>
<strong style="color:#ff3300">Please make sure the correct STL files are attached to your order.</strong>
</span> &nbsp;'
end