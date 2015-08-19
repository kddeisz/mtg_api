module MtgApi
  module Utilities
    class WhiteList

      attr_accessor :value

      def initialize(value)
        self.value = value

        unless valid?
          raise ArgumentError, "Invalid value given: #{value.inspect}"
        end
      end

      class << self
        attr_accessor :list
      end

      private

        def valid?
          if value.is_a?(Array)
            (value - self.class.list).any?
          else
            self.class.list.include?(value)
          end
        end
    end
  end
end
