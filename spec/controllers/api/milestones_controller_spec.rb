require 'spec_helper'

describe Api::MilestonesController do
  let(:milestone) { FactoryGirl.create(:milestone) }

  context "authorized" do
    before do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(milestone.project.owner.api_key)
    end

    describe "GET index" do
      before(:each) { get :index, project_id: milestone.project.to_param }

      it "renders successfully" do
        response.should be_success
      end

      it "assigns all milestones as @milestones" do
        assigns(:milestones).should eq([milestone])
      end
    end

    describe "GET show" do
      before(:each) { get :show, project_id: milestone.project.to_param, id: milestone.to_param }

      it "renders successfully" do
        response.should be_success
      end

      it "assigns the requested milestone as @milestone" do
        assigns(:milestone).should eq(milestone)
      end
    end
  end

  context "unauthorized" do
    describe "GET index" do
      before(:each) { get :index, project_id: milestone.project.to_param }

      it "doesn't render" do
        response.should_not be_success
      end
    end

    describe "GET show" do
      before(:each) { get :show, project_id: milestone.project.to_param, id: milestone.to_param }

      it "doesn't render" do
        response.should_not be_success
      end
    end
  end
end
