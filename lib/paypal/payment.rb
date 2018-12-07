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

    def update(payment_id:, options: {})
      request.patch(
        "v1/payments/payment/#{payment_id}",
        build_setup_request_body(options)
      )
    end

    def execute(payment_id:, payer_id:, options: {})
      request.post(
        "v1/payments/payment/#{payment_id}/execute",
        build_execute_request_body(options.merge(payer_id: payer_id))
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
        :items,
      )
    end

    def valid_options_for_execute(options)
      options.slice(
        :payer_id,
        :total,
        :currency
      )
    end

    def build_setup_request_body(options)
      opts = valid_options_for_setup(options)
      { intent: opts[:intent] }.tap do |hash|
        hash[:transactions] = [transaction_hash(opts)]
        hash[:payer] = { payment_method: 'paypal' }
        hash[:redirect_urls] = redirect_urls(opts)
      end.compact
    end

    def build_execute_request_body(options)
      opts = valid_options_for_execute(options)
      { payer_id: opts[:payer_id] }.tap do |hash|
        hash[:transactions] = [
          { amount: amount_hash(options) }
        ]
      end.compact
    end

    def transaction_hash(options)
      {
        amount: amount_hash(options),
        description: options[:description],
        custom: options[:custom],
        invoice_number: options[:invoice],
        item_list: { items: line_items_details(options[:items]) },
      }
    end

    def amount_hash(options)
      {
        currency: options[:currency],
        total: options[:total],
        details: amount_details(options),
      }
    end

    def amount_details(options)
      {
        subtotal: options[:subtotal],
        tax: options[:tax],
        shipping: options[:shipping],
        handling_fee: options[:handling],
        shipping_discount: options[:shipping_discount],
      }
    end

    def line_items_details(line_items)
      Array(line_items).map do |item|
        item.slice(:name, :description, :quantity, :price, :currency)
      end
    end

    def redirect_urls(options)
      options.slice(:cancel_url, :return_url)
    end
  end
end
