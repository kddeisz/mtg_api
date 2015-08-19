require 'test_helper'

class RequestEntityTest < Minitest::Test
  class SetterFake
    attr_accessor :value

    def initialize(value)
      self.value = value
    end

    def ==(other)
      value == other.value
    end
  end

  def test_initialize
    one_value = Object.new
    entity = fake_entity.new(attr_one: one_value, attr_four: Object.new)
    assert_equal entity.attr_one, one_value
  end

  def test_attributes
    attributes = { attr_one: Object.new, attr_two: Object.new, attr_three: Object.new }
    entity = fake_entity.new(attributes)

    attributes[:attr_three] = SetterFake.new(attributes[:attr_three])
    entity_attributes = entity.attributes

    [:attr_one, :attr_two, :attr_three].each do |attribute|
      assert_equal attributes[attribute], entity_attributes[attribute]
    end
  end

  def test_query_builder_delegation
    assert_kind_of MtgApi::QueryBuilder, fake_entity.where({})
    assert_kind_of MtgApi::QueryBuilder, fake_entity.limit(1)
    assert_kind_of MtgApi::QueryBuilder, fake_entity.order(:attr_one)
  end

  def test_configure
    entity = Class.new(MtgApi::RequestEntity)
    assert_nil entity.config

    entity.configure {}
    assert_kind_of MtgApi::Config, entity.config
  end

  def test_configure_defines_setters
    entity = Class.new(MtgApi::RequestEntity)
    entity.configure do
      setter :attr_one, SetterFake
    end

    assert entity.new.respond_to?(:attr_one)
    assert entity.new.respond_to?(:attr_one=)
  end

  def test_configure_defines_accessors
    entity = Class.new(MtgApi::RequestEntity)
    entity.configure do
      attribute :attr_one
      property :attr_two
    end

    %i[attr_one attr_two].each do |name|
      assert entity.new.respond_to?(name)
      assert entity.new.respond_to?("#{name}=".to_sym)
    end
  end

  private

    def fake_entity
      @fake_entity ||= begin
        entity = Class.new(MtgApi::RequestEntity)
        entity.configure do
          attribute :attr_one, :attr_two
          setter :attr_three, SetterFake
        end
        entity
      end
    end
end
