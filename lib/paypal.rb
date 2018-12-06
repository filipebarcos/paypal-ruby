# frozen_string_literal: true

require 'faraday'
require 'json'
require 'paypal/version'
require 'paypal/request'
require 'paypal/payment'
require 'paypal/oauth'

module Paypal
  @live_url = 'https://api.paypal.com/'
  @sandbox_url = 'https://api.sandbox.paypal.com/'

  class << self
    attr_reader :live_url, :sandbox_url
  end
end
