Spree::LineItem.class_eval do
  attr_accessor :options

  has_one :order_form

  after_create :save_order_form
  after_destroy :delete_order_form

  def save_order_form
    self.options.reject!{ |key| key == :currency }

    is_duplicate = self.options.has_key?('id')
    is_being_created_in_backend = self.options.empty?

    self.options.delete 'id' # needed for when doing a duplicate order
    self.options[:line_item_id] = self.id

    form = OrderForm.new(self.options)

    if is_duplicate or is_being_created_in_backend
      form.save!(validate: false)
    else
      form.save!
    end
  end

  def delete_order_form
    form = OrderForm.find_by_line_item_id(self.id)
    form.destroy if form
  end
end