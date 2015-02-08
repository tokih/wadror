require 'rails_helper'

describe "Beer" do
  it "can be created via web page if a name for the beer is entered" do
    User.create username:"Tomi", password:"S4l4k4l4", password_confirmation:"S4l4k4l4"
    sign_in(username:"Tomi", password:"S4l4k4l4")
    Brewery.create name:"testipanimo", year:2015
    visit new_beer_path
    fill_in('beer_name', with:'Test Beer')
    select('Lager', :from => 'beer_style')
    select('testipanimo', :from => 'beer_brewery_id')
    
    expect {
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
    expect(page).to have_content 'Test Beer'
  end
  it "can NOT be created via web page without a valid name and page is redirected to 'create beer' page after an invalid creation" do
    User.create username:"Tomi", password:"S4l4k4l4", password_confirmation:"S4l4k4l4"
    sign_in(username:"Tomi", password:"S4l4k4l4")
    Brewery.create name:"testipanimo", year:2015
    visit new_beer_path
    select('Lager', :from => 'beer_style')
    select('testipanimo', :from => 'beer_brewery_id')
    expect {
      click_button('Create Beer')
    }.not_to change{Beer.count}
    expect(page).to have_content 'New beer'
    expect(page).to have_content "Name can't be blank"
  end
end
