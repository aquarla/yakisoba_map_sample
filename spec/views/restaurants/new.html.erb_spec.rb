require 'rails_helper'

RSpec.describe "restaurants/new", type: :view do
  before(:each) do
    assign(:restaurant, Restaurant.new(
      :name => "MyString",
      :address => "MyString",
      :latitude => "9.99",
      :longitude => "9.99"
    ))
  end

  it "renders new restaurant form" do
    render

    assert_select "form[action=?][method=?]", restaurants_path, "post" do

      assert_select "input#restaurant_name[name=?]", "restaurant[name]"

      assert_select "input#restaurant_address[name=?]", "restaurant[address]"

      assert_select "input#restaurant_latitude[name=?]", "restaurant[latitude]"

      assert_select "input#restaurant_longitude[name=?]", "restaurant[longitude]"
    end
  end
end
