# frozen_string_literal: true
require 'spec_helper'
require 'paypal/payment'
require_relative '../../support/fake_request'

RSpec.describe Paypal::Payment do
  describe '#get_token' do
    it 'posts to v1/payments/payment' do
      common_params = { intent: 'intent', payer: 'payer' }
      request = FakeRequest.new({})

      allow(request)
        .to receive(:post)
        .with('v1/payments/payment', common_params)

      described_class
        .new(request: request)
        .get_token(common_params)
    end
  end
end
