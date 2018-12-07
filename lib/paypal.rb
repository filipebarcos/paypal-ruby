# frozen_string_literal: true

require 'faraday'
require 'json'
require_relative 'paypal/version'
require_relative 'paypal/response'
require_relative 'paypal/request'
require_relative 'paypal/payment'
require_relative 'paypal/oauth'

module Paypal
  @live_url = 'https://api.paypal.com/'
  @sandbox_url = 'https://api.sandbox.paypal.com/'

  class << self
    attr_reader :live_url, :sandbox_url
  end
end
