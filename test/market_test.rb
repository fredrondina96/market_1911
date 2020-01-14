require_relative '../lib/item'
require_relative '../lib/vendor'
require_relative '../lib/market'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class MarketTest < Minitest::Test

  def setup
    @market = Market.new("South Pearl Street Farmers Market")
  end

  def test_market_exists
    assert_instance_of Market, @market
  end

  def test_market_has_attributes
    assert_equal "South Pearl Street Farmers Market", @market.name
  end
end
