class Status < ActiveRecord::Base
  belongs_to :order, :class_name => 'Spree::Order'

  def change_status(status)
    if allowed_states.include? status
      self.current = status
      self.save
    else
      false
    end
  end

  private
    def allowed_states
      [
       'inbound',
       'in production',
       'shipped'
      ]
    end
end
