require 'pry'

class Market

attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    vendors_that_stock = []
        @vendors.each do |vendor|
          if (vendor.inventory.include?(item)==true)
            vendors_that_stock << vendor
          end
        end
    return vendors_that_stock
  end

  def sorted_item_list
    items_sold = []
      @vendors.each do |vendor|
        vendor.inventory.keys.each do |item|
          items_sold << item.name if (items_sold.include?(item.name) == false)
        end
      end
    return items_sold.sort { |a, b| a <=> b }
  end

  def total_inventory
    inventory_count = Hash.new(0)
      @vendors.each do |vendor|
        vendor.inventory.each do |item, amount|
          inventory_count[item] += amount
        end
      end
    return inventory_count
  end
end
