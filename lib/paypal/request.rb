# frozen_string_literal: true
require 'faraday'

module Paypal
  class Request
    def initialize(access_token:, test_mode: false, locale: 'en_US')
      @connection = Faraday.new(url: root_url(test_mode)) do |conn|
        conn.request(:url_encoded)
        conn.response(:logger)
        conn.adapter(Faraday.default_adapter)
      end

      @locale = locale
      @access_token = access_token
    end

    def post(path, payload = nil)
      request(:post, path, payload)
    end

    def patch(path, payload = nil)
      request(:patch, path, payload)
    end

    private

    attr_reader :connection, :locale, :access_token

    def request(method, path, payload = nil)
      response = connection.public_send(method) do |request|
        request.url(path)
        request.headers['Accept'] = 'application/json'
        request.headers['Content-Type'] = 'application/json'
        request.headers['Accept-Language'] = locale
        request.headers['Authorization'] = "Bearer #{access_token}"
        request.body = JSON.generate(payload) unless payload.nil?
        request.options.timeout = 2
        request.options.open_timeout = 1
      end

      Paypal::Response.new(response)
    end

    def root_url(test_mode)
      test_mode ? Paypal.sandbox_url : Paypal.live_url
    end
  end
end
