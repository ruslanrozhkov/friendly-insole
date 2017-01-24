Spree::User.class_eval do
  has_many :messages
  has_many :message_histories, through: :messages

  has_many :saved_line_items
end