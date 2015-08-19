module MtgApi
  module Utilities

    # stores the border of a card or set
    class Border < WhiteList

      self.list = %w[white black silver]

    end
  end
end
