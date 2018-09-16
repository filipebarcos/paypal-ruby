# frozen_string_literal: true

$LOAD_PATH.unshift(::File.join(::File.dirname(__FILE__), 'lib'))

require 'paypal/version'

Gem::Specification.new do |s|
  s.name        = 'paypal-ruby'
  s.version     = Paypal::VERSION
  s.date        = '2018-09-16'
  s.summary     = 'Ruby wrapper for PayPal REST API'
  s.description = 'Ruby wrapper for PayPal REST API'
  s.authors     = 'Filipe Costa'
  s.email       = 'filipebarcos@gmail.com'
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- test/*`.split("\n")
  s.license     = 'MIT'
end
