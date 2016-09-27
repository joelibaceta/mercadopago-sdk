 
module ActiveRest
  
  module Mapping
    
    module ClassMethods
      
      def get(name, url, options = {})
        _map_call(name, url: url, method: :get,     options:options)
      end
      
      def put(name, url, options = {})
        _map_call(name, url: url, method: :put,     options:options)
      end
      
      def delete(name, url, options = {})
        _map_call(name, url: url, method: :delete,  options:options)
      end
      
      def post(name, url, options = {})
        _map_call(name, url: url, method: :post,    options:options)
      end
      
      def patch(name, url, options = {})
        _map_call(name, url: url, method: :patch,   options:options)
      end 
      
      def attribute(name, type: String)
        @_attrs[name]
      end
      
      def _call(name, options) 
        mapped  = _calls[name]
        mapped  = _calls[name.to_s.to_sym] if mapped.nil? 
        #request = Request.new(mapped, self, options) 
        #request.call  
      end

      def define_parameters(&block); yield; end

      def param(definition)
        name, type = definition
        _params[name.is_a? Symbol ? name : name.to_sym] = type
      end
      
      def _calls; @_calls; end
      def _params; @_params; end

      def _mapped_method(name)
        _calls[name]
      end
      
      def _mapped_attribute(name)
        _attrs[name]
      end
      
      def _map_call(name, details)
        _calls[name] = {name:name}.merge(details) 
        self.class.send(:define_method, name) do |options={}|
          _call(name, options)
        end
      end
    
      def inherited(subclass) 
        subclass.instance_variable_set(:@_calls,  {})
        subclass.instance_variable_set(:@_params, {})
      end 

    end
    
    def self.included(base)
      base.extend(ClassMethods)
    end
    
  end

end
