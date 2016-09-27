module MercadoPago
  class Preference < ActiveREST::Base

    orrm_method :create, post:  '/checkout/preferences'
    orrm_method :read,   get:   '/checkout/preferences/:id'
    orrm_method :update, put:   '/checkout/preferences/:id'

    define_parameters do

      param id:                  Integer
      param auto_return:         String

      param back_urls: {
            success: String,
            pending: String,
            failure: String
      }

      param init_point:          String
      param sandbox_init_point:  String
      param operation_type:      String
      param additional_info:     String
      param external_reference:  String
      param notification_url:    String
      param date_created:        String
      param collector_id:        Integer
      param client_id:           Integer
      param marketplace:         String
      param marketplace_fee:     Float

    end

    validate :notification_url, lenght: 500

  end
end