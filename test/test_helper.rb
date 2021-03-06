require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mtg_api'

require 'bundler'
Bundler.require

require 'minitest/autorun'
require 'minitest/mock'

require 'support/server_faking'
require 'support/white_list_interface'
require 'support/white_list_testing'

Minitest::Test.include(ServerFaking)
Minitest::Test.include(WhiteListTesting)
