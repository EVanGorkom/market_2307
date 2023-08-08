require './lib/item'

RSpec.describe Item do    
  it "exists and has attributes" do
    item_details = { name: 'Peach', price: "$0.75" }
    item = Item.new(item_details)

    expect(item).to be_an_instance_of Item  
    expect(item.name).to eq "Peach"
    expect(item.price).to eq 0.75
  end
end