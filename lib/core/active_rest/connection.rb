module ActiveRest

  class TimeoutException < StandardError ; end
  class ConnectionFailedException < StandardError ; end
  
  class Connection

    attr_accessor :session, :base_url

    def initialize(base_url)
      @base_url = base_url
      @session  = new_session
    end

    def reconnect
      @session  = new_session
    end

    def headers
      @session.headers
    end

    def make_safe_request(path, &block)
      block.call
    rescue Faraday::Error::TimeoutError
      raise ActiveRestClient::TimeoutException.new("Timed out getting #{full_url(path)}")
    rescue Faraday::Error::ConnectionFailed
      begin
        reconnect
        block.call
      rescue Faraday::Error::ConnectionFailed
        raise ActiveRestClient::ConnectionFailedException.new("Unable to connect to #{full_url(path)}")
      end
    end

    private

    def new_session
      uri   = URI.parse(@base_url)
      conn  = Net::HTTP.new(uri.host, uri.port)
      ActiveRestClient::Base.set_default_connection_config(conn)
    end


    def set_defaults(options)
      options[:headers]   ||= {}
      return options
    end



    
  end
  
end