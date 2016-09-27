require_relative "active_rest/configuration"
require_relative "active_rest/validation"
require_relative "active_rest/request_triggering"
require_relative "active_rest/request"
require_relative 'active_rest/mapping'
require_relative 'active_rest/orrm_methods'
require_relative "active_rest/base"



module ActiveREST

  Config = Struct.new(:base_url)
  
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Config.new
  end

  def self.reset
    @configuration = Config.new
  end

  def self.configure
    yield(configuration)
  end
  
end