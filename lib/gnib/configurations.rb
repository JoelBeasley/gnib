module Gnib
  class Configurations
    private_class_method :new
    attr_accessor :account_key, :api_root

    def self.singleton_object
      @singleton ||= new
    end
    def api_root
      #maybe NEWS or something based on how it interperts
      @api_root ||= 'https://api.datamarket.azure.com/Bing/Search/v1'
    end

    private
      # Prevent external initialization
      def initialize; super; end
  end
end
