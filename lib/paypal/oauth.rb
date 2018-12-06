# string_frozen_literal: true
require 'faraday'

module Paypal
  class Oauth
    def initialize(test_mode: false, locale: 'en_US')
      @connection = Faraday.new(url: root_url(test_mode)) do |conn|
        conn.request :url_encoded
        conn.response :logger
        conn.basic_auth(CLIENT_ID, SECRET_TOKEN)
        conn.adapter Faraday.default_adapter
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

    LIVE_URL = 'https://api.paypal.com/'
    SANDBOX_URL = 'https://api.sandbox.paypal.com/'
    CLIENT_ID = ''
    SECRET_TOKEN = ''

    attr_reader :connection, :locale

    def root_url(test_mode)
      test_mode ? SANDBOX_URL : LIVE_URL
    end
  end
end
