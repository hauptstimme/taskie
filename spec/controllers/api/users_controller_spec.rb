require 'spec_helper'

describe Api::UsersController do
  let(:user) { FactoryGirl.create(:user) }

  context "authorized" do
    before do
      request.headers['Authorization'] = ActionController::HttpAuthentication::Token.encode_credentials(user.api_key)
    end

    describe "GET show" do
      before(:each) { get :show, id: user.username }

      it "renders successfully" do
        expect(response).to be_success
      end

      it "assigns the requested user as @user" do
        expect(assigns(:user)).to eq(user)
      end
    end
  end

  context "unauthorized" do
    describe "GET show" do
      before(:each) { get :show, id: user.to_param }

      it "doesn't render" do
        expect(response).not_to be_success
      end
    end
  end
end
