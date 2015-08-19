require 'test_helper'

class SetTypeTest < Minitest::Test
  include WhiteListInterface

  def clazz
    MtgApi::Utilities::SetType
  end
end
