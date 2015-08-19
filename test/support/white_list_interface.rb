module WhiteListInterface

  def setup
    @previous_list = clazz.list
    clazz.list = %w[one two three]
  end

  def teardown
    clazz.list = @previous_list
  end

  def test_initialize_valid_individual
    whitelist = clazz.new('one')
    assert_equal 'one', whitelist.value
  end

  def test_initialize_invalid_individaul
    assert_raises ArgumentError do
      whitelist = clazz.new('four')
    end
  end

  def test_initialize_valid_list
    whitelist = clazz.new(%w[one two])
    assert_equal %w[one two], whitelist.value
  end

  def test_initialize_invalid_list
    assert_raises ArgumentError do
      whitelist = clazz.new(%w[one two four])
    end
  end
end
