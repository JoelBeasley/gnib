module Gnib
  class Response
    SOURCES = [:web, :image, :news, :spell, :phonebook, :related_search, :translation, :video]
    def initialize(body)
      @response_hash = JSON.parse(body)['d']['results']
    end

    def results_for(source)
      results_container = @response_hash[0][source.to_s.camelize]
      if results_container
        @response_hash[0][source.to_s.camelize].map do |result|
          SearchResult.new result
        end
      else
        []
      end
    end

    def result_count_of(source)
      @response_hash[source.to_s.camelize]['Total'].to_i
    end

    def results
      ret = []

      SOURCES.each do |type, v|
        ret ||= results_for(type)
      end

      ret
    end

    def method_missing(method, *args, &block)
      singluar_form = method.to_s.singularize.to_sym

      if SOURCES.include? singluar_form
        results_for(singluar_form)
      else
        super
      end
    end
  end
end
