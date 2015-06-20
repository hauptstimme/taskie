require 'spec_helper'

describe PagesController do
  let(:user) { FactoryGirl.create(:user) }

  context "authorized" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "GET dashboard" do
      let!(:project) { FactoryGirl.create(:project) }
      let!(:active_task) { FactoryGirl.create(:task, assignee: user, project: project) }
      let!(:completed_task) { FactoryGirl.create(:task, assignee: user, project: project, status: :completed) }

      it "returns http success" do
        get :dashboard
        expect(response).to be_success
      end

      it "assigns user's active tasks as @active_tasks_by_projects" do
        get :dashboard
        expect(assigns(:active_tasks_by_projects)).to eq(project => [active_task])
      end
    end
  end

  context "unauthorized" do
    describe "GET dashboard" do
      it "redirects to sign in" do
        get :dashboard
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
