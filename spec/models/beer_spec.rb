require 'rails_helper'

describe Beer do

  it "is created and saved when name and style have been defined" do
    beer = Beer.create name:"Halcyon", style:"IPA"

    expect(beer).to be_valid
    expect(beer.persisted?).to eq(true)
  end

  it "is NOT created when no name has been defined" do
    beer = Beer.create style:"lowalcohol"

    expect(beer).not_to be_valid
    expect(beer.persisted?).to eq(false)
  end

  it "is NOT created when no style has been defined" do
    beer = Beer.create name:"Jaipur"
   
    expect(beer).not_to be_valid
    expect(beer.persisted?).to eq(false)
  end

end
