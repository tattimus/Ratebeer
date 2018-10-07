require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    canned_answer = <<-END_OF_STRING
    {"location":{"name":"Helsinki","region":"Southern Finland","country":"Finland","lat":60.18,"lon":24.93,"tz_id":"Europe/Helsinki","localtime_epoch":1538934118,"localtime":"2018-10-07 20:41"},"current":{"last_updated_epoch":1538933410,"last_updated":"2018-10-07 20:30","temp_c":3.0,"temp_f":37.4,"is_day":0,"condition":{"text":"Partly cloudy","icon":"//cdn.apixu.com/weather/64x64/night/116.png","code":1003},"wind_mph":4.3,"wind_kph":6.8,"wind_degree":330,"wind_dir":"NNW","pressure_mb":1012.0,"pressure_in":30.4,"precip_mm":0.0,"precip_in":0.0,"humidity":93,"cloud":25,"feelslike_c":1.1,"feelslike_f":34.1,"vis_km":10.0,"vis_miles":6.0}}
    END_OF_STRING
    stub_request(:get, /.*kumpula/).to_return(body: canned_answer, headers: {'Content-Type' => "text/json"})
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if several are returned by the API, all are show at the page" do
    canned_answer = <<-END_OF_STRING
    {"location":{"name":"Helsinki","region":"Southern Finland","country":"Finland","lat":60.18,"lon":24.93,"tz_id":"Europe/Helsinki","localtime_epoch":1538934118,"localtime":"2018-10-07 20:41"},"current":{"last_updated_epoch":1538933410,"last_updated":"2018-10-07 20:30","temp_c":3.0,"temp_f":37.4,"is_day":0,"condition":{"text":"Partly cloudy","icon":"//cdn.apixu.com/weather/64x64/night/116.png","code":1003},"wind_mph":4.3,"wind_kph":6.8,"wind_degree":330,"wind_dir":"NNW","pressure_mb":1012.0,"pressure_in":30.4,"precip_mm":0.0,"precip_in":0.0,"humidity":93,"cloud":25,"feelslike_c":1.1,"feelslike_f":34.1,"vis_km":10.0,"vis_miles":6.0}}
    END_OF_STRING
    stub_request(:get, /.*kumpula/).to_return(body: canned_answer, headers: {'Content-Type' => "text/json"})
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name:"Oljenkorsi", id: 1 ), Place.new( name:"Kuusenkeppi", id: 2) ]
      )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Kuusenkeppi"
  end

  it "if non are found with the given city, error message is shown" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ ]
      )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end
end