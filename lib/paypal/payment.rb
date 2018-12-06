# frozen_string_literal: true

module Paypal
  class Payment
    def initialize(request:)
      @request = request
    end

    def get_token(intent:, payer:, options: {})
      request.post(
        'v1/payments/payment',
        options.merge(intent: intent, payer: payer)
      )
    end

    private

    attr_reader :request
  end
end
