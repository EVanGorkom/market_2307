require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  before(:each) do
    @item1 = Item.new({ name: 'Peach', price: "$0.75" })
    @item2 = Item.new({ name: 'Tomato', price: "$0.50" })
    @item3 = Item.new({ name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Rocky Mountain Fresh")
    @vendor3 = Vendor.new("Rocky Mountain Fresh")
  end

  it "exists and has readable attributes" do
    expect(@vendor1).to be_an_instance_of Vendor
    expect(@vendor1.name).to eq "Rocky Mountain Fresh"
    expect(@vendor1.inventory).to eq({})
  end

  describe "#check_stock" do
    it "can check the total stock of a specific item" do
      expect(@vendor1.check_stock(@item1)).to eq 0
    end
  end
  
  describe "#stock" do
    it "can add stock of an item to the store" do
      @vendor1.stock(@item1, 30)
      expect(@vendor1.inventory).to be_a Hash
      expect(@vendor1.check_stock(@item1)).to eq 30

      @vendor1.stock(@item2, 12)
      expect(@vendor1.inventory).to be_a Hash
      expect(@vendor1.check_stock(@item2)).to eq 12
    end
  end

  describe "#potential_revenue" do
    it "can determine to expected revenue of the vendor1's stock" do
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)

      expect(@vendor1.potential_revenue).to eq 29.75
      expect(@vendor2.potential_revenue).to eq 345.00
      expect(@vendor3.potential_revenue).to eq 48.75
    end
  end
end