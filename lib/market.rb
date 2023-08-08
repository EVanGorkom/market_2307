class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(new_vendor)
    @vendors << new_vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end
  
  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor_names if vendor.inventory.include?(item)
    end
  end

  def sorted_item_list
    all_items = @vendors.map do |vendor|
      vendor.inventory.keys
    end
    unique_items = all_items.flatten.uniq.map do |item|
      item.name
    end
    unique_items.sort
  end

  def total_inventory
    inventory = Hash.new { |hash, key| hash[key] = { quantity: 0, vendors: [] } }
    
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        inventory[item][:quantity] += quantity
        inventory[item][:vendors] << vendor
      end
    end
    inventory
  end

  def overstocked_items
    overstocked = total_inventory.find_all do |item, info|
      info[:quantity] > 50 && info[:vendors].size > 1
    end
    overstocked.map do |item_details|
      item_details.first
    end
  end
end