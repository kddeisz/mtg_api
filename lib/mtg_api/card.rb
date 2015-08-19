module MtgApi
  class Card < RequestEntity

    configure do
      attr :artist, :border, :cmc, :colors, :flavor, :foreign_names, :hand, :layout
      attr :legalities, :life, :loyalty, :mana_cost, :multiverseid, :name, :names
      attr :number, :original_text, :original_type, :power, :printings, :rarity
      attr :rulings, :set, :subtypes, :supertypes, :text, :toughness, :type, :types
      attr :variations, :watermark

      prop :images, :links

      setter :border, Utilities::Border
      setter :colors, Utilities::ColorList
    end
  end
end
