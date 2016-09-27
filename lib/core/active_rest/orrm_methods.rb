
module ActiveREST
  module ORRM_Methods



    module ClassMethods


      def load

      end

      def load_all

      end

      def new

      end

      def create

      end

    end

    def self.included(base)
      base.extend(ClassMethods)
    end


    def save

    end

    def update

    end

    def destroy

    end


  end
end
