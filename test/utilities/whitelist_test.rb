require 'test_helper'

class WhiteListTest < Minitest::Test
  include WhiteListInterface

  def clazz
    MtgApi::Utilities::WhiteList
  end
end
