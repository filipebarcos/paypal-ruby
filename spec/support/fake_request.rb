# frozen_string_literal: true

class FakeRequest
  def initialize(fake_response)
    @fake_response = fake_response
  end

  def post(path, payload)
    @fake_response
  end
end
