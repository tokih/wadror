require 'rails_helper'

RSpec.describe "styles/index", type: :view do
  before(:each) do
    assign(:styles, [
      Style.create!(
        :description => "Description"
      ),
      Style.create!(
        :description => "Description"
      )
    ])
  end

  it "renders a list of styles" do
    render
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
