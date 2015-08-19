require 'test_helper'

class SetTest < Minitest::Test

  def test_border=
    assert_white_list_setter(MtgApi::Set, :border, 'white', MtgApi::Utilities::Border)
  end

  def test_links=
    card_link, booster_link = Object.new, Object.new
    set = MtgApi::Set.new(links: { 'cards' => card_link, 'booster' => booster_link })

    assert_equal card_link, set.links.cards
    assert_equal booster_link, set.links.booster
  end

  def test_release_date=
    set = MtgApi::Set.new(release_date: nil)
    assert_nil set.release_date

    set = MtgApi::Set.new(release_date: 'Sept 1, 1900')
    assert_equal Date.parse('Sept 1, 1900'), set.release_date
  end

  def test_type=
    assert_white_list_setter(MtgApi::Set, :type, 'commander', MtgApi::Utilities::SetType)
  end

  def test_cards
    skip
  end
end
