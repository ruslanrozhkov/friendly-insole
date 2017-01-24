Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "inject-tracking-modal-into-admin-panel",
                     :insert_top => "body.admin",
                     :partial => "modals/tracking_modal")