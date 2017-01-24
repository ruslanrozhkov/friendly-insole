require 'ostruct'

Spree::Shipment.class_eval do
  has_one :shipping_label

  def item_count
    total_items = 0

    self.line_items.each do |item|
      total_items += item.quantity unless item.nil?
    end

    return total_items
  end

  def dimension_totals
    totals = OpenStruct.new({
        weight: 0,
        width:  0,
        length: 0,
        height: 0,
    })

    # We need to combine the weight of all the items in the shipment
    # and increase the height dimensions of the box as per the height given to the variant
    #
    # We also need to grab the largest dimension of a variant in the shipment for the width
    # and the depth/length so that the items will all fit in the box
    self.line_items.each do |item|
      unless item.nil?
        item.quantity.times do
          totals.weight += item.variant.weight
          totals.width  =  item.variant.width if totals.width < item.variant.width
          totals.length =  item.variant.depth if totals.length < item.variant.depth
          totals.height += item.variant.height
        end
      end
    end

    return totals
  end

end