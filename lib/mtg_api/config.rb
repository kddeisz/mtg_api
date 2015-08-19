module MtgApi
  class Config

    attr_accessor :attributes, :name, :properties, :setters

    def initialize(clazz)
      self.name = clazz.name
      self.attributes = []
      self.properties = []
      self.setters = {}
    end

    def accessors
      attributes + properties - setters.keys
    end

    def attr(*attrs)
      self.attributes += attrs
    end

    def endpoint
      @endpoint ||= '/' + response_key
    end

    def full_config
      (attributes + properties + setters.keys).uniq
    end

    def prop(*props)
      self.properties += props
    end

    def response_key
      @response_key ||= name.downcase.split('::').last + 's'
    end

    def setter(attribute, clazz = nil, &block)
      setters[attribute] = Proc.new do |value|
        value = clazz.nil? ? block.call(value) : clazz.new(value)
        instance_variable_set(:"@#{attribute}", value)
      end
    end
  end
end
