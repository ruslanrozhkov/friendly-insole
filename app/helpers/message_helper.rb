module MessageHelper

  def has_read(user, message)
    MessageHistory.find_by(user: user, message: message, read: true).present?
  end

end
