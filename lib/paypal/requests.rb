# frozen_string_literal: true

module Paypal
  class Requests
    def initialize(access_token:, test_mode: false, locale: 'en_US')
      @connection = Faraday.new(url: root_url(test_mode)) do |conn|
        conn.request :url_encoded
        conn.response :logger
        conn.adapter Faraday.default_adapter
      end

      @locale = locale
      @access_token = access_token
    end

    def post(path, payload = nil)
      connection.post do |request|
        request.url(path)
        request.headers['Accept'] = 'application/json'
        request.headers['Accept-Language'] = locale
        request.headers['Authorization'] = "Bearer #{access_token}"
        request.body = JSON.generate(payload) unless payload.nil?
        request.options.timeout = 2
        request.options.open_timeout = 1
      end
    end

    private

    LIVE_URL = 'https://api.paypal.com/'
    SANDBOX_URL = 'https://api.sandbox.paypal.com/'

    attr_reader :connection, :locale, :access_token

    def root_url(test_mode)
      test_mode ? SANDBOX_URL : LIVE_URL
    end
  end
end
