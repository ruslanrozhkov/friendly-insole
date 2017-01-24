# Preview at http://localhost:3000/rails/mailers/shipment_mailer/shipped_email_preview
class ShipmentMailerPreview < ActionMailer::Preview
  def shipped_email_preview
    Spree::ShipmentMailer.shipped_email(Spree::Shipment.find_by_id(33))
  end
end