require 'test_helper'

class RequestTest < Minitest::Test

  def test_root_url
    refute_nil MtgApi::Request::ROOT_URL
  end

  def test_initialize
    request = MtgApi::Request.new('/test')
    assert_kind_of URI, request.endpoint
    assert_equal 'test', request.endpoint.to_s.split('/').last
  end

  def test_response
    request = MtgApi::Request.new('/test')
    fake_server do
      assert_equal ServerFaking.fake_response_for('/test'), request.response
    end
  end

  def test_response_for
    request = MtgApi::Request.new('/test')
    fake_server do
      response = request.response_for('test').first
      assert_equal ({ 'attr_one' => 'first_value_one', 'attr_two' => 'first_value_two' }), response
    end
  end
end
