class Message < ActiveRecord::Base
  belongs_to :order, :class_name => 'Spree::Order'
  belongs_to :user, :class_name => 'Spree::User'
  belongs_to :role, :class_name => 'Spree::Role'

  alias_attribute :intended_for, :role

  validates :order, :user, presence: true

  has_many :message_histories

  def set_read_state(user, state)
    message_history = MessageHistory.where(user: user, message: self).first_or_initialize
    message_history.read = state
    message_history.save
  end
end
