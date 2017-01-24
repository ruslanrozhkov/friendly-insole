Spree::Order.class_eval do
  has_one :status
  has_one :manufacturer_shipment
  has_many :messages

  self.register_line_item_comparison_hook(:product_customizations_match)

  self.whitelisted_ransackable_attributes =  %w[completed_at created_at email number state payment_state shipment_state total considered_risky approver_id]


  # Always insert a new line item when an item is added to the cart
  def product_customizations_match(line_item, options)
    # comparing_form = line_item.order_form.attributes.dup
    # comparing_form.reject!{ |key| %w"line_item_id id created_at updated_at".include? key }
    #
    # #needs more special cases, we'll leave this for now and just always create a new line item
    # comparing_form == options
    false
  end

  # def self.search(search, state, start_date, end_date)
  #   start_date = start_date.blank? ? Time.at(0) : Date.strptime(start_date, "%m/%d/%Y")
  #   end_date = end_date.blank? ? Time.now : Date.strptime(end_date, "%m/%d/%Y")
  #
  #   return where('number like ?', "%#{search}%")
  #              .where('state like ?', "%#{state}%")
  #              .where(:completed_at => start_date.beginning_of_day..end_date.end_of_day)
  # end

  def generate_status
    if self.state == 'complete' || self.state == 'resumed'
      if self.status.present?
        if self.shipped?
          Spree.t("shipment_states.#{self.shipment_state}").titleize if self.shipment_state
        else
          if self.status.current == 'shipped'
            'In Production'
          elsif self.status.current == 'inbound'
            'Approved'
          else
            self.status.current.titleize
          end
        end
      else
        'Pending Approval'
      end
    else
      self.state.titleize # effectively canceled
    end
  end

end