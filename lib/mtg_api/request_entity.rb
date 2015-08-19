module MtgApi

  # represents an entity being returned from the API
  class RequestEntity

    # build a card set from a set of attributes
    def initialize(attributes = {})
      attributes.each do |key, value|
        if self.respond_to?(:"#{key}=")
          self.send(:"#{key}=", value)
        end
      end
    end

    # the attributes of this request entity
    def attributes
      self.class.config.full_config.map { |attribute| [attribute, self.send(attribute)] }.to_h
    end

    class << self
      # the stored Config instance for this class
      attr_accessor :config

      extend Forwardable
      def_delegators :config, :attributes, :properties
      def_delegators :query_builder, :all, :limit, :where, :first, :last, :order

      # build a config and evaluate the block inside of it
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

        # build a query builder whenever query methods are called on this class
        def query_builder
          QueryBuilder.new(self)
        end
    end
  end
end
