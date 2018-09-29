require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is created and saved if it has name, style and brewery" do
    brewery = Brewery.new name: "Olvi", year: "1878"
    beer = Beer.create name:"IPA", style:"IPA", brewery: brewery
    expect(beer.valid?).to be(true)
    expect(Beer.count).to eq(1)
  end
  it "is not validated if not given name" do
    brewery = Brewery.new name: "Olvi", year: "1878"
    beer = Beer.create style:"IPA", brewery: brewery
    expect(beer.valid?).to be(false)
  end
  it "is not validated if not given style" do
    brewery = Brewery.new name: "Olvi", year: "1878"
    beer = Beer.create name:"IPA", brewery: brewery
    expect(beer.valid?).to be(false)
  end
end
