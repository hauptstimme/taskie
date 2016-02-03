require 'spec_helper'

describe Api::MilestonesController do
  let(:milestone) { FactoryGirl.create(:milestone) }

  context "authorized" do
    before do
      request.headers['Authorization'] =
        ActionController::HttpAuthentication::Token.encode_credentials(milestone.project.owner.api_key)
    end

    describe "GET index" do
      before(:each) { get :index, project_id: milestone.project.to_param }

      it "renders successfully" do
        expect(response).to be_success
      end

      it "assigns all milestones as @milestones" do
        expect(assigns(:milestones)).to eq([milestone])
      end
    end

    describe "GET show" do
      before(:each) { get :show, project_id: milestone.project.to_param, id: milestone.to_param }

      it "renders successfully" do
        expect(response).to be_success
      end

      it "assigns the requested milestone as @milestone" do
        expect(assigns(:milestone)).to eq(milestone)
      end
    end
  end

  context "unauthorized" do
    describe "GET index" do
      before(:each) { get :index, project_id: milestone.project.to_param }

      it "doesn't render" do
        expect(response).not_to be_success
      end
    end

    describe "GET show" do
      before(:each) { get :show, project_id: milestone.project.to_param, id: milestone.to_param }

      it "doesn't render" do
        expect(response).not_to be_success
      end
    end
  end
end
