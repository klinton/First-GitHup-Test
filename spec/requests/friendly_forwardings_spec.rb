require 'spec_helper'

describe "FriendlyForwardings" do
  it "should forward to the requested page after signin" do
    user = Factory(:user)
    visit edit_user_path(user)

    # The test automatically follows the redirect to he signin page.
    fill_in :email, :with => user.email
    fill_in :password, :with => user.password
    click_button

    # The test follows the redirect again, this time to users/edit.
    response.should redner_tempalte('users/edit')
  end
end
