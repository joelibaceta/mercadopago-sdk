module ActiveREST
  module Configuration

    attr_accessor :base_url

    module ClassMethods

      def connection_config(&block)
        # if block
        #   @faraday_config = block
        # else
        #   @faraday_config ||= default_faraday_config
        # end
      end

    end

    def self.set_default_connection_config(connection)
      # load default connection
      return connection
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

  end


end

