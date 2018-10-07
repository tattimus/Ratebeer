require 'rails_helper'

include Helpers

describe "Beers" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
  let!(:user) { FactoryBot.create :user }
  let!(:style) { FactoryBot.create :style, name:"IPA" }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given valid name, is added to DB" do
    visit new_beer_path
    expect(current_path).to eq(new_beer_path)
    fill_in('beer[name]', with: 'IPA')
    select('IPA', from:'beer[style_id]')
    select('Koff', from:'beer[brewery_id]')

    expect{
        click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "when given empty name is not added to DB and user is given proper error message" do
    visit new_beer_path
    fill_in('beer[name]', with: '')
    select('IPA', from:'beer[style_id]')
    select('Koff', from:'beer[brewery_id]')

    expect{
        click_button "Create Beer"
    }.to change{Beer.count}.by(0)
    expect(page).to have_content "Name can't be blank"
    
  end

end