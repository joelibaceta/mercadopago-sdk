 
module ActiveREST
  
  module Mapping
    
    module ClassMethods

      def orrm_method(method, action)
        action_method, url = action.first
        options = {}

        _map_call(method, url: url, method: action_method, options:options)
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
        name, type = definition.first
        name = name.class == Symbol ? name : name.to_sym
        _params[name] = type
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
