module MtgApi
  module Utilities
    class SetLinks

      attr_accessor :cards, :booster

      def initialize(args = {})
        self.cards = args[:cards]
        self.booster = args[:booster]
      end
    end
  end
end
