require 'pry'

class Item

attr_reader :name, :price

  def initialize(item_attributes = {})
    @name = item_attributes[:name]
    @price = item_attributes[:price]
  end

end
