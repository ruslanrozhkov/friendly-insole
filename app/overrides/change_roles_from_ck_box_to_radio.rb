Deface::Override.new(:virtual_path => "spree/admin/users/_form",
                     :name => "change-roles-from-ck-box-to-radio",
                     :replace_contents => "[data-hook='admin_user_form_roles']",
                     :partial => "spree/admin/users/user_roles_select")