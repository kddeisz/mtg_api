module MtgApi

  # builds and sends requests to the api server
  class Request

    # the root url of the api
    ROOT_URL = 'http://api.mtgapi.com/v2'

    # the url for this request
    attr_accessor :endpoint

    # build a new request
    def initialize(endpoint)
      self.endpoint = URI(ROOT_URL + endpoint)
    end

    # get the response
    def response
      puts "\e[32mGET #{endpoint}\e[0m"
      @response ||= JSON.parse(raw_response)
    end

    # the section of the response, formatted in snake case
    def response_for(response_key)
      (response[response_key] || []).map do |entity|
        rubyify(entity)
      end
    end

    private

      # the response from the server
      def raw_response
        Net::HTTP.get(endpoint)
      end

      # format a hash to have snake case keys
      def rubyify(entity)
        entity.map do |key, value|
          [key.to_s.gsub(/([A-Z])/) { '_' + $1.downcase }, value]
        end.to_h
      end
  end
end
