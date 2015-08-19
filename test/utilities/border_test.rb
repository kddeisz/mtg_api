require 'test_helper'

class BorderTest < Minitest::Test
  include WhiteListInterface

  def clazz
    MtgApi::Utilities::Border
  end
end
