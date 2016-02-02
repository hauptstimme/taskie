require 'spec_helper'

describe SettingsController do
  let(:user) { FactoryGirl.create(:user) }

  context "authorized" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "GET show" do
      it "returns http success" do
        get :show
        expect(response).to be_success
      end
    end

    describe "PATCH update" do
      describe "with valid params" do
        it "updates the requested comment" do
          expect_any_instance_of(User).to receive(:update).with("time_zone" => "Central Time (US & Canada)")
          patch :update, user: { "time_zone" => "Central Time (US & Canada)" }
        end

        before(:each) { patch :update, user: { "time_zone" => "Central Time (US & Canada)" } }

        it "updates current user's time_zone" do
          expect(user.reload.time_zone).to eq("Central Time (US & Canada)")
        end

        it "redirects to the settings" do
          expect(response).to redirect_to(settings_path)
        end
      end

      describe "with invalid params" do
        before :each do
          allow_any_instance_of(User).to receive(:save).and_return(false)
          patch :update, user: { "time_zone" => "No such time zone" }
        end

        it "renders show action" do
          expect(response).to render_template("show")
        end
      end
    end
  end

  context "unauthorized" do
    describe "GET show" do
      it "redirects to sign in" do
        get :show
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PATCH update" do
      it "redirects to sign in" do
        patch :update, user: { "time_zone" => "Central Time (US & Canada)" }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
