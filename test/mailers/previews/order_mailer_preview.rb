# Preview at http://localhost:3000/rails/mailers/order_mailer/confirm_email_preview
class OrderMailerPreview < ActionMailer::Preview
  def cancel_email_preview
    Spree::OrderMailer.cancel_email(Spree::Order.find_by_id(39))
  end

  def confirm_email_preview
    Spree::OrderMailer.confirm_email(Spree::Order.find_by_id(39))
  end
end