require 'paypal'

RSpec.describe Paypal do
  describe '#testing' do
    it 'works' do
      expect(Paypal.testing).to eq 'paypal'
    end
  end
end
