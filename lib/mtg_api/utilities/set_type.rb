module MtgApi
  module Utilities
    class SetType < WhiteList

      self.list = ['archenemy', 'box', 'commander', 'conspiracy', 'core', 'duel deck', 'expansion',
        'from the vault', 'masters', 'planechase', 'premium deck', 'promo', 'reprint', 'starter', 'un', 'vanguard']

    end
  end
end
