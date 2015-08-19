require 'test_helper'

class SetLinksTest < Minitest::Test

  def test_initialize
    card_link, booster_link = Object.new, Object.new
    links = MtgApi::Utilities::SetLinks.new(cards: card_link, booster: booster_link)

    assert_equal card_link, links.cards
    assert_equal booster_link, links.booster
  end
end
