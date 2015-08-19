require 'test_helper'

class ColorListTest < Minitest::Test
  include WhiteListInterface

  def clazz
    MtgApi::Utilities::ColorList
  end
end
