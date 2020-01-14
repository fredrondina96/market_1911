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
end
