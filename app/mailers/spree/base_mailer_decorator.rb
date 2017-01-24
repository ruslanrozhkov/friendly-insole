Spree::BaseMailer.class_eval do
  before_action :embed_images, except: [:from_address, :money, :mail]

  def embed_images
    attachments.inline[Spree::Config.logo] = File.read(Rails.root.join("app/assets/images/#{Spree::Config.logo}"))
  end
end