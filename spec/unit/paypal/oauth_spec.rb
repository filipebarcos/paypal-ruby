# frozen_string_literal: true
require 'spec_helper'
require 'paypal/oauth'

RSpec.describe Paypal::Oauth do
  describe '#access_token' do
    it 'posts to v1/oauth2/token' do
      connection = double(Faraday::Connection)
      request = double(Faraday::Request)
      allow(Faraday).to receive(:new).and_return(connection)
      expect(connection).to receive(:post) # .and_yield(request, )

      described_class.new.access_token
    end
  end
end
