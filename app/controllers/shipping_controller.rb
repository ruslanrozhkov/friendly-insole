class ShippingController < ApplicationController

  def track(number = params[:id])
    shipment = USPS::Shipment.new

    render json: shipment.track(number)
  end

  def generate_label
    # We always assume there will only be one shipment since we took out
    # functionality for splitting shipments
    shipment = USPS::Shipment.new

    usps_response = shipment.generate_label(OpenStruct.new params[:shipment])

    if usps_response['Error'].present?
      flash[:error] = usps_response['Error']['Description']
      redirect_to request.referrer
    else
      # Save the tracking number
      order = Spree::Order.find_by_number(params[:order_number])
      order.shipments.each { |shipment| shipment.tracking = usps_response['DelivConfirmCertifyV4.0Response']['DeliveryConfirmationNumber'] }
      order.save!

      @pdf_label = usps_response['DelivConfirmCertifyV4.0Response']['DeliveryConfirmationLabel']

      @shipping_label = ShippingLabel.find_or_initialize_by(shipment: order.shipments.first)
      @shipping_label.created_by = spree_current_user if @shipping_label.created_by.nil?
      @shipping_label.updated_by = spree_current_user

      begin
        file = Tempfile.new(["shipping_label_#{params[:order_number]}-", '.pdf'])
        file.binmode
        file.write Base64.decode64(@pdf_label)

        @shipping_label.label =  file

        file.close
        if @shipping_label.save
          flash[:success] = 'USPS shipping label successfully created and saved'
        else
          flash[:error] = 'Failed to save USPS shipping label'
        end
        redirect_to request.referrer
      ensure
        file.unlink
      end

    end
  end

end
