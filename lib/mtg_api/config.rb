module MtgApi

  # the configured properties of an entity
  class Config

    # the stored properties of this config
    attr_accessor :attributes, :name, :properties, :setters

    # store the class name and initialize empty lists
    def initialize(clazz)
      self.name = clazz.name
      self.attributes = []
      self.properties = []
      self.setters = {}
    end

    # the list of attributes to build attr_accessors for
    def accessors
      attributes + properties - setters.keys
    end

    # add to the attributes list (queryable)
    def attr(*attrs)
      self.attributes += attrs
    end

    # the endpoint to send to the api for the entity
    def endpoint
      @endpoint ||= '/' + response_key
    end

    # the full list of attributes set
    def full_config
      (attributes + properties + setters.keys).uniq
    end

    # add to the properties list (unqueryable)
    def prop(*props)
      self.properties += props
    end

    # the key in the response for the api
    def response_key
      @response_key ||= name.downcase.split('::').last + 's'
    end

    # build a setter that can map the return value from the api
    def setter(attribute, clazz = nil, &block)
      setters[attribute] = Proc.new do |value|
        value = clazz.nil? ? block.call(value) : clazz.new(value)
        instance_variable_set(:"@#{attribute}", value)
      end
    end
  end
end
