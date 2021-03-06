require_relative '../lib/item'
require_relative '../lib/vendor'
require_relative '../lib/market'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class MarketTest < Minitest::Test

  def setup
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @vendor3.stock(@item1, 65)
  end

  def test_market_exists
    assert_instance_of Market, @market
  end

  def test_market_has_attributes
    assert_equal "South Pearl Street Farmers Market", @market.name
    assert_equal [], @market.vendors
  end

  def test_market_can_add_vendors
    @market.add_vendor(@vendor1)
    assert_equal 1, @market.vendors.length
    assert_includes @market.vendors, @vendor1
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    assert_equal 3, @market.vendors.length
    assert_includes @market.vendors, @vendor2
    assert_includes @market.vendors, @vendor3
  end

  def test_market_can_return_just_vendor_names
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expected = ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
    assert_equal expected, @market.vendor_names
  end

  def test_market_can_return_vendors_that_stock_certain_item
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    assert_includes @market.vendors_that_sell(@item1), @vendor1
    assert_includes @market.vendors_that_sell(@item1), @vendor3
    refute_includes @market.vendors_that_sell(@item1), @vendor2
  end

  def test_market_can_return_sorted_list_of_stocked_items
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expected = ["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"]
    assert_equal expected, @market.sorted_item_list
  end

  def test_market_can_return_total_inventory
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    assert_equal [100, 7, 50, 25], @market.total_inventory.values
    assert_includes @market.total_inventory.keys, @item1
    assert_includes @market.total_inventory.keys, @item2
    assert_includes @market.total_inventory.keys, @item3
    assert_includes @market.total_inventory.keys, @item4
  end

  def test_market_can_sell_items
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    refute @market.sell(@item1, 200)
    refute_nil @market.sell(@item1, 200)
    refute @market.sell(@item5, 1)
    refute_nil @market.sell(@item5, 1)
    assert @market.sell(@item1, 5)
    assert_equal 30, @vendor1.check_stock(@item1)
    assert @market.sell(@item1, 40)
    assert_equal 0, @vendor1.check_stock(@item1)
    assert_equal 55, @vendor3.check_stock(@item1)
  end
end
