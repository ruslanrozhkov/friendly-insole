Deface::Override.new(:virtual_path => "spree/admin/shared/_head",
                     :name => "replace-spree-admin-title",
                     :replace_contents => "title") do
  'Friendly Insole - Headquarters'
end