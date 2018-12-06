# frozen_string_literal: true
require 'spec_helper'
require 'paypal'

RSpec.describe Paypal::Oauth do
  describe '#access_token' do
    it 'posts to v1/oauth2/token' do
      connection = double(Faraday::Connection)
      request = double(Faraday::Request)
      allow(Faraday).to receive(:new).and_return(connection)
      expect(connection).to receive(:post) # .and_yield(request, )

      described_class.new(client_id: 'client_id', secret_token: 'secret_token').access_token
    end
  end
end
