# string_frozen_literal: true
require 'faraday'

module Paypal
  class Oauth
    def initialize(test_mode: false, locale: 'en_US')
      @connection = Faraday.new(url: root_url(test_mode)) do |conn|
        conn.request(:url_encoded)
        conn.response(:logger)
        conn.basic_auth(Paypal.api_client, Paypal.secret_token)
        conn.adapter(Faraday.default_adapter)
      end

      @locale = locale
    end

    def access_token
      connection.post do |request|
        request.url 'v1/oauth2/token'
        request.headers['Accept'] = 'application/json'
        request.headers['Accept-Language'] = locale
        request.body = { grant_type: 'client_credentials'}
      end
    end

    private

    attr_reader :connection, :locale

    def root_url(test_mode)
      test_mode ? Paypal.sandbox_url : Paypal.live_url
    end
  end
end
