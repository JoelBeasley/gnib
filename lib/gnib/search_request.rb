require 'uri'
require 'net/https'
require 'base64'

module Gnib
  class SearchRequest
    def initialize(uri)
      @uri = uri
    end

    def response
      @response_body ||= do_http_request.body
      Response.new(@response_body)
    end

    protected
      def do_http_request
        acctKey = Gnib.config.account_key
        authKey = Base64.strict_encode64("#{acctKey}:#{acctKey}")
        
        http = Net::HTTP.new(@uri.host, @uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(@uri.request_uri)
        request.add_field "Authorization", "Basic #{authKey}"
        res = http.request(request)
      end
  end
end

