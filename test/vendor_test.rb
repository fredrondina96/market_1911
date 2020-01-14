require_relative '../lib/item'
require_relative '../lib/vendor'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class VendorTest < Minitest::Test

  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  def test_vendor_exists
    assert_instance_of Vendor, @vendor
  end

  def test_vendor_has_attributes
    assert_equal "Rocky Mountain Fresh", @vendor.name
    assert_equal ({}), @vendor.inventory
  end

  def test_vendor_can_check_stock_of_items
    assert_equal 0, @vendor.check_stock(@item1)
  end

  def test_vendor_can_restock_items
    @vendor.stock(@item1, 30)
     assert_equal 30, @vendor.inventory[@item1]
  end
end
