require 'uri'
require 'net/http'
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
      acctKey = "123"
      authKey = Base64.strict_encode64("#{acctKey}:#{acctKey}")
      def do_http_request
        http = Net::HTTP.new(@uri.host, @uri.port)
        request = Net::HTTP::Get.new(@uri.request_uri)
        request.add_field "Authorization", "Basic #{authKey}"
        http.request(request)
      end
  end
end

