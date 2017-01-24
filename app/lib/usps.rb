module USPS
  class Shipment
    include HTTParty

    # base_uri 'http://production.shippingapis.com/ShippingApi.dll'
    base_uri 'https://secure.shippingapis.com/ShippingApi.dll'

    def user_id
      '174FLICK6310'
    end

    def track(number)
      params = {
          'TrackFieldRequest' => {
              'TrackID' => {

              }, :attributes! => { 'TrackID' => { 'ID' => number } }
          }, :attributes! => { 'TrackFieldRequest' => { 'USERID' => self.user_id } }
      }

      xml = Gyoku.xml(params).to_s

      options = {
          :query => {
              :API => 'TrackV2',
              :XML => xml
          }
      }

      self.class.get('', options)
    end

    def generate_label(shipment)
      params = {
          'DelivConfirmCertifyV4.0Request' => {

              'FromName' => shipment.from_name,
              'FromFirm' => shipment.from_firm || '',
              'FromAddress1' => shipment.from_address_2, # this is the suite number
              'FromAddress2' => shipment.from_address_1, # this is actually the main address
              'FromCity' => shipment.from_city,
              'FromState' => shipment.from_state,
              'FromZip5' => shipment.from_zip_5,
              'FromZip4' => '',

              'ToName' => shipment.to_name,
              'ToFirm' => shipment.to_firm || '',
              'ToAddress1' => shipment.to_address_2,
              'ToAddress2' => shipment.to_address_1,
              'ToCity' => shipment.to_city,
              'ToState' => shipment.to_state,
              'ToZip5' => shipment.to_zip_5,
              'ToZip4' => '',
              'ToContactPreference' => 'EMAIL',
              'ToContactMessaging' => shipment.to_email,
              'ToContactEMail' => shipment.to_email,

              'WeightInOunces' => shipment.weight,
              'ServiceType' => shipment.service_type,
              # 'InsuredAmount' => '',
              # 'SeparateReceiptPage' => '',
              # 'POZipCode' => '',
              # 'InsuredAmount' => '',
              # 'InsuredAmount' => '',
              'ImageType' => 'PDF',
              'Container' => 'RECTANGULAR',
              'Size' => 'LARGE',

              'Width' => shipment.width,
              'Length' => shipment.length,
              'Height' => shipment.height,


              'CommercialPrice' => true,
              'ExtraServices' => {
                  'ExtraService' => 155, # USPS tracking
              }
          }, :attributes! => { 'DelivConfirmCertifyV4.0Request' => { 'USERID' => self.user_id } }
      }

      xml = Gyoku.xml(params).to_s

      options = {
          :query => {
              :API => 'DelivConfirmCertifyV4', # replace with DeliveryConfirmationV4 when ready
              :XML => xml
          }
      }

      response = self.class.get('', options)

      return response
    end
  end
end
