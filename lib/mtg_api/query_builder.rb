module MtgApi
  class QueryBuilder

    attr_accessor :clazz, :stored_conditions, :stored_limit, :stored_order

    extend Forwardable
    def_delegators :all, :each, :last, :inspect

    include Enumerable

    def initialize(clazz)
      self.clazz = clazz
      self.stored_conditions = {}
    end

    def all
      response = Request.new(endpoint).response_for(clazz.config.response_key)
      response = response[0...stored_limit] unless stored_limit.nil?

      response.map! do |attributes|
        clazz.new(attributes)
      end
      response.sort_by!(&stored_order.to_proc) unless stored_order.nil?

      response
    end

    def limit(limit)
      unless limit > 0
        raise ArgumentError, "Invalid limit given: #{limit}"
      end

      self.stored_limit = limit
      self
    end

    def order(order)
      unless clazz.attributes.include?(order)
        raise ArgumentError, "Invalid order given: #{order}"
      end

      self.stored_order = order
      self
    end

    def where(conditions)
      if (invalid = (conditions.keys - clazz.attributes)).any?
        raise ArgumentError, "Invalid conditions given: #{invalid.join(', ')}"
      end

      self.stored_conditions.merge!(conditions)
      self
    end

    private

      def endpoint
        endpoint = clazz.config.endpoint.dup
        if stored_conditions.any?
          endpoint << '?' + stored_conditions.map { |key, value| URI.escape("#{key}=#{value}") }.join('&')
        end
        endpoint
      end
  end
end
