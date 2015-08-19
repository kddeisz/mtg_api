module MtgApi
  module Utilities

    # a class that validates that the initialization value is
    # contained in the list stored on the class
    class WhiteList

      # the value of this instance of a whitelist
      attr_accessor :value

      # store and validate the given value
      def initialize(value)
        self.value = value

        unless valid?
          raise ArgumentError, "Invalid value given: #{value.inspect}"
        end
      end

      class << self
        # the list of available values
        attr_accessor :list
      end

      private

        # whether or not the given value is valid
        def valid?
          if value.is_a?(Array)
            (value - self.class.list).none?
          else
            self.class.list.include?(value)
          end
        end
    end
  end
end
