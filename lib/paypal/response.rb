# frozen_string_literal: true
require 'json'

module Paypal
  class Response
    def initialize(raw_response)
      @raw_response = raw_response
    end

    def [](key)
      body[key]
    end

    private

    attr_reader :raw_response

    def body
      @body ||= begin
        JSON.parse(raw_response.body)
      rescue JSON::ParserError
        {}
      end
    end
  end
end
