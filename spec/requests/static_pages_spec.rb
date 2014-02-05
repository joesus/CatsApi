require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Dogs'" do
      visit root_path
      expect(page).to have_content('Dogs')
    end
  end

  describe "Contact page" do
  	it "should have the content 'Contact'" do
  		#
  		#
  	end
  end
end