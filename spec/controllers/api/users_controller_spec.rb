require 'spec_helper'

describe Api::UsersController do
  let(:user) { FactoryGirl.create(:user) }

  context "authorized" do
    before do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.api_key)
    end

    describe "GET show" do
      before(:each) { get :show, id: user.username }

      it "renders successfully" do
        response.should be_success
      end

      it "assigns the requested user as @user" do
        assigns(:user).should eq(user)
      end
    end
  end

  context "unauthorized" do
    describe "GET show" do
      before(:each) { get :show, id: user.to_param }

      it "doesn't render" do
        response.should_not be_success
      end
    end
  end
end
