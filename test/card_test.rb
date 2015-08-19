require 'test_helper'

class CardTest < Minitest::Test

  def test_border=
    assert_white_list_setter(MtgApi::Card, :border, 'white', MtgApi::Utilities::Border)
  end

  def test_colors=
    assert_white_list_setter(MtgApi::Card, :colors, %w[white green], MtgApi::Utilities::ColorList)
  end

  def test_set
    skip
  end
end
