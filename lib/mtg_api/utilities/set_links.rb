module MtgApi
  module Utilities

    # stores the links to the cards or booster of a set
    class SetLinks

      # the urls
      attr_accessor :cards, :booster

      # store the given values
      def initialize(args = {})
        self.cards = args[:cards]
        self.booster = args[:booster]
      end
    end
  end
end
