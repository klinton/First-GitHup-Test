require 'spec_helper'

describe "Users" do
  describe "signup" do
    describe "sign in/out" do

      describe "sio failure" do
        it "should not sign a user in" do
          visit signin_path
          fill_in :email,   :with => ""
          fill_in :password, :with => ""
          click_button
          response.should have_selector("div.flash.error", 
                                         :content => "Invalid")
        end
      end

      describe "sio success" do
        it "should sign a user in and out" do
          user = Factory(:user)
          visit signin_path
          fill_in :email,   :with => user.email
          fill_in :password, :with => user.password
          click_button
          controller.should be_signed_in
          click_link "Sign Out"
          controller.should_no be_signed_in
        end
      end
    end

    describe "su success" do

      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "Yogi Bear"
          fill_in "Email",        :with => "theavgbear@jellystonepark.gov"
          fill_in "Password",     :with => "Picnic Basket"
          fill_in "Confirmation", :with => "Picnic Basket"
          click_button
#          response.should have_selector("div.flash.success", 
#                                         :content => "Welcome")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end

    describe "su failure" do

      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button

          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end
  end
end
