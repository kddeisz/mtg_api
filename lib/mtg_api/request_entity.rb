module MtgApi
  class RequestEntity

    # build a card set from a set of attributes
    def initialize(attributes = {})
      attributes.each do |key, value|
        if self.respond_to?(:"#{key}=")
          self.send(:"#{key}=", value)
        end
      end
    end

    def attributes
      self.class.attributes.map { |attribute| [attribute, self.send(attribute)] }.to_h
    end

    class << self
      attr_accessor :config

      extend Forwardable
      def_delegators :config, :attr, :attributes, :prop, :properties, :setter
      def_delegators :query_builder, :all, :limit, :where, :first, :last, :order

      def configure(&block)
        self.config = Config.new(self)
        config.instance_eval(&block)

        attr_accessor *config.accessors
        attr_reader *config.setters.keys

        config.setters.each do |name, definition|
          define_method(:"#{name}=", definition)
        end
      end

      private

        def query_builder
          QueryBuilder.new(self)
        end
    end
  end
end
