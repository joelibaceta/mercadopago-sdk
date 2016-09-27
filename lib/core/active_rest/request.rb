require 'net/http'

module ActiveRest
  class Request 
    
    VERB_MAP = {
        :get    => Net::HTTP::Get,
        :post   => Net::HTTP::Post,
        :put    => Net::HTTP::Put,
        :delete => Net::HTTP::Delete
    } 
    
    def initialize(method, object, params = {})
      p "METHOD: #{method} " #{:name=>:find, :url=>"/preference/:id", :method=>:get, :options=>{}}
      p "OBJECT: #{object} " #"<Dummy:0x007fd8419defb0 @attributes={}, @dynamic_attributes=#<Set: {}>, @structure=#<Set: {}>>"
      p "PARAMS: #{params}"
      
      verb  = VERB_MAP[method[:method]]
      uri   = URI.parse(fill_url_template(method[:url], object))
      http  = Net::HTTP.new(uri.host, uri.port) 

      
    end
    
    def call
      
    end
    
    private 
    
    def fill_url_template(url, object) 
      url.split('/').each do |term| 
        method_name = term.gsub(':', '')
        guess_value = object.__send__(method_name).to_s rescue term
        url         = url.gsub(term, guess_value) if term.include?(":")
      end
      return url
    end
    
  end
end