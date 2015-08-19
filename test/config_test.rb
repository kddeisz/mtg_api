require 'test_helper'

class ConfigTest < Minitest::Test
  class Double
    Triple = Class.new
    def initialize(value); end
  end

  def test_initialize
    config = new_config

    assert_equal Object.name, config.name
    assert_empty config.attributes
    assert_empty config.properties
    assert_empty config.setters
  end

  def test_accessors
    config = new_config
    config.attributes = %w[one two three]
    config.properties = %w[four five six]
    config.setters = { 'one' => nil, 'four' => nil, 'six' => nil}

    assert_equal %w[two three five], config.accessors
  end

  def test_attribute
    config = new_config

    config.attribute 'one'
    assert_equal ['one'], config.attributes

    config.attribute *%w[two three]
    assert_equal %w[one two three], config.attributes
  end

  def test_endpoint
    config = new_config(Double)
    assert_equal '/doubles', config.endpoint

    config = new_config(Double::Triple)
    assert_equal '/triples', config.endpoint
  end

  def test_full_config
    config = new_config(Object)
    config.attribute *%w[one two]
    config.property *%w[two three]
    config.setter 'four', Double

    assert_equal %w[one two three four], config.full_config
  end

  def test_property
    config = new_config

    config.property 'one'
    assert_equal ['one'], config.properties

    config.property *%w[two three]
    assert_equal %w[one two three], config.properties
  end

  def test_response_key
    config = new_config(Double)
    assert_equal 'doubles', config.response_key

    config = new_config(Double::Triple)
    assert_equal 'triples', config.response_key
  end

  def test_setter_no_class
    config = new_config
    config.setter :first do |value|
      value.to_s
    end

    instance = Object.new
    instance.singleton_class.instance_eval do
      define_method :first, &config.setters[:first]
    end

    assert_equal '1', instance.first(1)
  end

  def test_setter_class
    config = new_config
    config.setter :first, Double

    instance = Object.new
    instance.singleton_class.instance_eval do
      define_method :first, &config.setters[:first]
    end

    assert_kind_of Double, instance.first('value')
  end

  private

    def new_config(clazz = Object)
      MtgApi::Config.new(clazz)
    end
end
