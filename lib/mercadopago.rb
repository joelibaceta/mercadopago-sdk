require_relative '/core/active_rest.rb'

Dir["#{File.dirname(__FILE__)}/entities/**/*.rb"].each { |f| load f }

module MercadoPago



end