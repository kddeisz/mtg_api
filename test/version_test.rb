require 'test_helper'

class VersionTest < Minitest::Test

  def test_version
    refute_nil MtgApi::VERSION
  end
end
