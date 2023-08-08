require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  before(:each) do
    item_details_1 = { name: 'Peach', price: "$0.75" }
    @item1 = Item.new(item_details_1)
    item_details_2 = { name: 'Tomato', price: "$0.50" }
    @item2 = Item.new(item_details_2)
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  it "exists and has readable attributes" do
    expect(@vendor).to be_an_instance_of Vendor
    expect(@vendor.name).to eq "Rocky Mountain Fresh"
    expect(@vendor.inventory).to eq({})
  end

  describe "#check_stock" do
    it "can check the total stock of a specific item" do
      expect(@vendor.check_stock(@item1)).to eq 0
    end
  end
  
  describe "#stock" do
    it "can add stock of an item to the store" do
      @vendor.stock(@item1, 30)
      expect(@vendor.inventory).to be_a Hash
      expect(@vendor.check_stock(@item1)).to eq 30

      @vendor.stock(@item2, 12)
      expect(@vendor.inventory).to be_a Hash
      expect(@vendor.check_stock(@item2)).to eq 12
    end
  end
end