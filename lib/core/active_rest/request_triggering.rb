
module ActiveREST

  module RequestTriggering

    module ClassMethods
      
      def before_each_request(&block)
        @before_filters ||= []
        if block
          @before_filters << block 
        end
      end
      
      def after_each_request(&block)
        @after_filters ||= []
        if block
          @after_filters << block 
        end
      end
      
      def before_request(method_name = nil, &block)
        @before_filters ||= []
        if block
          @before_filters << block
        elsif method_name
          @before_filters << method_name
        end
      end
      
      def after_request(method_name = nil, &block)
        @after_filters ||= []
        if block
          @after_filters << block
        elsif method_name
          @after_filters << method_name
        end
      end

    end
    
    def self.included(base)
      base.extend(ClassMethods)
    end
    
  end
  
end