require 'test_helper'

class QueryBuilderTest < Minitest::Test
  class ConfigFake
    def endpoint
      '/test'
    end

    def response_key
      'test'
    end
  end

  class EntityFake
    attr_accessor :attr_one, :attr_two, :attr_three

    def initialize(attrs = {})
      attrs.each do |key, value|
        instance_variable_set(:"@#{key}", value)
      end
    end

    def self.attributes
      %i[attr_one attr_two attr_three]
    end

    def self.config
      ConfigFake.new
    end
  end

  def test_initialize
    builder = MtgApi::QueryBuilder.new(Object)
    assert_equal Object, builder.clazz
    assert_empty builder.stored_conditions
  end

  def test_all
    builder = MtgApi::QueryBuilder.new(EntityFake)
    fake_server do
      entities = builder.all

      assert_kind_of EntityFake, entities.first
      assert_equal 'first_value_one', entities.first.attr_one
      assert_equal 'first_value_two', entities.first.attr_two
    end
  end

  def test_all_with_order
    builder = MtgApi::QueryBuilder.new(EntityFake)

    fake_server do
      builder.order(:attr_one)
      sorted = builder.all.map(&:attr_one)
      assert_equal sorted, sorted.sort

      builder.order(:attr_two)
      sorted = builder.all.map(&:attr_two)
      assert_equal sorted, sorted.sort
    end
  end

  def test_all_with_limit
    builder = MtgApi::QueryBuilder.new(EntityFake)
    builder.limit(2)

    fake_server { assert_equal 2, builder.all.size }
  end

  def test_all_with_conditions
    builder = MtgApi::QueryBuilder.new(EntityFake)
    builder.where(attr_one: 'first_value_one')

    endpoint = fake_server do
      builder.all
    end

    assert_match /\?attr_one=first_value_one$/, endpoint.to_s
  end

  def test_limit_valid
    builder = MtgApi::QueryBuilder.new(Object)
    builder.limit(5)
    assert_equal 5, builder.stored_limit
  end

  def test_limit_invalid
    builder = MtgApi::QueryBuilder.new(Object)
    assert_raises ArgumentError do
      builder.limit(-1)
    end
  end

  def test_limit_chainable
    builder = MtgApi::QueryBuilder.new(Object)
    assert_equal builder, builder.limit(1)
  end

  def test_order_valid
    builder = MtgApi::QueryBuilder.new(EntityFake)
    builder.order(:attr_one)
    assert_equal :attr_one, builder.stored_order
  end

  def test_order_invalid
    builder = MtgApi::QueryBuilder.new(EntityFake)
    assert_raises ArgumentError do
      builder.order(:attr_four)
    end
  end

  def test_order_chainable
    builder = MtgApi::QueryBuilder.new(EntityFake)
    assert_equal builder, builder.order(:attr_one)
  end

  def test_where_single
    value = Object.new
    builder = MtgApi::QueryBuilder.new(EntityFake)
    builder.where(attr_one: value)

    assert_equal ({ attr_one: value }), builder.stored_conditions
  end

  def test_where_multiple
    one_value, two_value = Object.new, Object.new
    builder = MtgApi::QueryBuilder.new(EntityFake)
    builder.where(attr_one: one_value, attr_two: two_value)

    assert_equal ({ attr_one: one_value, attr_two: two_value }), builder.stored_conditions
  end

  def test_where_overwrite
    original, overwrite = Object.new, Object.new
    builder = MtgApi::QueryBuilder.new(EntityFake)

    builder.where(attr_one: original)
    builder.where(attr_one: overwrite)

    assert_equal overwrite, builder.stored_conditions[:attr_one]
  end

  def test_where_invalid
    builder = MtgApi::QueryBuilder.new(EntityFake)
    assert_raises ArgumentError do
      builder.where(attr_four: Object.new)
    end
  end

  def test_where_chainable
    builder = MtgApi::QueryBuilder.new(EntityFake)
    assert_equal builder, builder.where(attr_one: Object.new)
  end
end
