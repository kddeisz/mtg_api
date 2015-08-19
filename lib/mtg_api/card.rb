module MtgApi

  # represents a card in MtG
  class Card < RequestEntity

    configure do
      attribute :artist, :border, :cmc, :colors, :flavor, :foreign_names, :hand, :layout
      attribute :legalities, :life, :loyalty, :mana_cost, :multiverseid, :name, :names
      attribute :number, :original_text, :original_type, :power, :printings, :rarity
      attribute :rulings, :set, :subtypes, :supertypes, :text, :toughness, :type, :types
      attribute :variations, :watermark

      property :images, :links

      setter :border, Utilities::Border
      setter :colors, Utilities::ColorList
    end

    # the set that this card corresponds to
    def set
      Set.where(code: @set).first
    end
  end
end
