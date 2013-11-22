require 'spec_helper'

describe SettingsController do
  let(:user) { FactoryGirl.create(:user) }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "GET show" do
    it "returns http success" do
      get :show
      response.should be_success
    end
  end

  describe "PATCH update" do
    describe "with valid params" do
      it "updates the requested comment" do
        User.any_instance.should_receive(:update).with({ "time_zone" => "Central Time (US & Canada)" })
        put :update, user: { "time_zone" => "Central Time (US & Canada)" }
      end

      before(:each) { put :update, user: { "time_zone" => "Central Time (US & Canada)" } }

      it "updates current user's time_zone" do
        user.reload.time_zone.should == "Central Time (US & Canada)"
      end

      it "redirects to the settings" do
        response.should redirect_to(settings_path)
      end
    end

    describe "with invalid params" do
      before :each do
        User.any_instance.stub(:save).and_return(false)
        put :update, user: { "time_zone" => "No such time zone" }
      end

      it "renders show action" do
        response.should render_template("show")
      end
    end
  end
end
