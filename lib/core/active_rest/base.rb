require_relative 'mapping' 


module ActiveRest
  
  class Base
    include Mapping
    include Validation
    include RequestTriggering
    
    attr_accessor :_headers
    
    instance_methods.each do |m|
      next unless %w{display presence load require hash untrust trust freeze method enable_warnings with_warnings suppress capture silence quietly debugger breakpoint}.map(&:to_sym).include? m
      undef_method m
    end
    
    def initialize(attrs={})
      @attributes  = {}
      @dynamic_attributes = Set.new
      @structure = Set.new

      raise Exception.new("Cannot instantiate Base class") if self.class.name == "ActiveRestClient::Base"
      
    end
    
    def attributes
      @attributes
    end
    
    def method_missing(name, *args)
      if name.to_s[-1,1] == "="
        name = name.to_s.chop.to_sym 
        @attributes[name] = args.first 
      else
        name_sym  = name.to_sym
        name      = name.to_s
        if @attributes.has_key? name_sym
          @attributes[name_sym]
        else
          if mapped = self.class._mapped_method(name_sym)
            #raise ValidationFailedException.new unless valid?
            request = Request.new(mapped, self, args.first)
            request.call
          elsif self.class.whiny_missing
            raise NoAttributeException.new("Missing attribute #{name_sym}")
          else
            nil
          end
        end
        
      end
        
    end
    
    
    
  end
  
  class NoAttributeException < StandardError ; end
  class ValidationFailedException < StandardError ; end
  class MissingOptionalLibraryError < StandardError ; end
  
end
