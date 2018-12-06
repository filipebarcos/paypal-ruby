# frozen_string_literal: true

module Paypal
  class Payment
    def initialize(request:)
      @request = request
    end

    def setup(intent:, options: {})
      request.post(
        'v1/payments/payment',
        build_setup_request_body(options.merge(intent: intent))
      )
    end

    def execute(payer_id:, options: {})
      request.post(
        "v1/payments/payment/#{payer_id}/execute",
        options, # body => maybe do something like setup method does
      )
    end

    private

    attr_reader :request

    def valid_options_for_setup(options)
      options.slice(
        :intent,
        :return_url,
        :cancel_url,
        :total,
        :currency,
        :description,
        :line_items,
      )
    end

    def build_setup_request_body(options)
      opts = valid_options_for_setup(options)
      { intent: opts[:intent] }.tap do |hash|
        hash[:transactions] = [transaction_hash(opts)]
        hash[:description] = opts[:description]
        hash[:item_list] = { items: line_items(opts) }
      end.compact
    end

    def transaction_hash(options)
      options.slice(:total, :currency)
    end

    def line_items_details(line_items)
      Array(line_items).map do |item|

      end
    end
  end
end
