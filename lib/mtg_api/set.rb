module MtgApi
  class Set < RequestEntity

    configure do
      attr :block, :border, :code, :gatherer_code, :name
      attr :old_code, :online_only, :release_date, :type

      prop :card_count, :links, :symbol_images

      setter :border, Utilities::Border
      setter :links do |links|
        Utilities::SetLinks.new(links.map { |key, value| [key.to_sym, value] }.to_h)
      end
      setter :release_date do |date|
        Date.parse(date) if date
      end
      setter :type, Utilities::SetType
    end

    # the cards that belong to this set
    def cards
      Card.where(set: code)
    end
  end
end
