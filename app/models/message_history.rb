class MessageHistory < ActiveRecord::Base
  belongs_to :message
  belongs_to :user, :class_name => 'Spree::User'
end
