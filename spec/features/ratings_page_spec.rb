require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryBot.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "(s) are shown at the index site and their number is on display" do
    FactoryBot.create(:rating, score: 20, beer: beer1, user: user)
    visit ratings_path
    expect(page).to have_content "Number of ratings: 1"
    expect(page).to have_content "20"
    expect(page).to have_content "iso 3"
  end

  it "is shown only in that users site who gave it" do
    FactoryBot.create(:rating, score: 20, beer: beer1, user: user)
    user2 = FactoryBot.create(:user, username: "Matti")
    FactoryBot.create(:rating, score: 30, beer: beer2, user: user2)
    visit user_path(user)
    expect(page).to have_content "iso 3"
    expect(page).not_to have_content "Karhu"
    expect(page).to have_content "Has made 1 rating, average rating 20.0"
  end

  it "is removed from DB when user deletes it" do
    FactoryBot.create(:rating, score: 20, beer: beer1, user: user)
    visit user_path(user)
    expect{
        click_link "delete"
    }.to change{Rating.count}.from(1).to(0)
  end

end