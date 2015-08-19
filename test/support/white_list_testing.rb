module WhiteListTesting

  private

    # assert that the given clazz has a setter for a whitelist with the given value
    def assert_white_list_setter(clazz, attr, value, whitelist_clazz)
      instance = clazz.new(attr => value)
      assert_kind_of whitelist_clazz, instance.send(attr)
      assert_equal value, instance.send(attr).value
    end
end
