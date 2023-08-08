require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Vendor do
  before(:each) do
    @item1 = Item.new({ name: 'Peach', price: "$0.75" })
    @item2 = Item.new({ name: 'Tomato', price: "$0.50" })
    @item3 = Item.new({ name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")

    @market = Market.new("South Pearl Street Farmers Market")
  end

  it "exists and has readable attributes" do
    expect(@market).to be_an_instance_of Market
    expect(@market.name).to eq "South Pearl Street Farmers Market"
    expect(@market.vendors).to eq([])
  end
  
  describe "#add_vendor" do
  it "can add a vendor to the market" do
    expect(@market.vendors).to eq([])
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    
    expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    end
  end

  describe "#vendor_names" do
    it "can return the names of all of the vendors in the market" do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end

  describe "#vendors_that_sell" do
    it "can return an array of vendors that sell a specific item" do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
  
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)

      expect(@market.vendors_that_sell(@item1)).to eq [@vendor1, @vendor3]
    end
  end

  describe "#sorted_item_list" do
    it "returns an array of sorted item names from all vendors" do 
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
  
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)

      expect(@market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
    end
  end

  describe "#total_inventory" do
    it "returns a hash of total inventory for all items sold at the markert" do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)

      expected_result = {
        @item1 => { quantity: 100, vendors: [@vendor1, @vendor3] },
        @item2 => { quantity: 7, vendors: [@vendor1] },
        @item4 => { quantity: 50, vendors: [@vendor2] },
        @item3 => { quantity: 25, vendors: [@vendor2] }
      }

      expect(@market.total_inventory).to eq expected_result
    end
  end
end