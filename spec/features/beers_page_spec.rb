require 'rails_helper'

include Helpers

describe "Beers" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
  
  it "when given valid name, is added to DB" do
    visit new_beer_path
    fill_in('beer[name]', with: 'kalia')
    select('IPA', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')

    expect{
        click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "when given empty name is not added to DB and user is given proper error message" do
    visit new_beer_path
    fill_in('beer[name]', with: '')
    select('IPA', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')

    expect{
        click_button "Create Beer"
    }.to change{Beer.count}.by(0)
    expect(page).to have_content "Name can't be blank"
    
  end

end