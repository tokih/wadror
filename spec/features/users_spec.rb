require 'rails_helper'

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")
      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end
  end
  describe "who has signed up" do
    # ...

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")
      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end
  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')
    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "lists all ratings given by this user on his/her page" do
    user = FactoryGirl.create :user, username:"Tomi", password:"S4k4k4l4", password_confirmation:"S4k4k4l4"
    rating1 = FactoryGirl.create :rating, score:12
    rating2 = FactoryGirl.create :rating, score:45
    rating3 = FactoryGirl.create :rating, score:33
    beer1 = FactoryGirl.create :beer
    beer1.ratings << rating1
    beer1.ratings << rating2
    beer1.ratings << rating3
    user.ratings << rating1
    user.ratings << rating2
    visit user_path(user)
    expect(page).to have_content 'has made 2 ratings'
    expect(page).to have_content 'average 28.5'
  end

  it "can delete his/her own ratings" do
    user = User.create(username:"Tomi", password:"S4l4k4l4", password_confirmation:"S4l4k4l4")
    sign_in(username:"Tomi", password:"S4l4k4l4")
    brewery = Brewery.create(name:"Test Brewery", year:2015)
    beer = Beer.create(name:"Test Beer", style:"Lager", brewery:brewery)
    visit new_rating_path
    select('Test Beer', :from => 'rating_beer_id')
    fill_in('rating_score', with:'44')
    click_button('Create Rating')
    visit user_path(user)
    expect {
      page.find(:xpath, "//a[@href='/ratings/#{user.ratings.first.id}']").click
    }.to change{Rating.count}.by(-1)
  end
end
