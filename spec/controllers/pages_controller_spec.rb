require 'spec_helper'

describe PagesController do
  let(:user) { FactoryGirl.create(:user) }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "GET dashboard" do
    it "returns http success" do
      get :dashboard
      response.should be_success
    end

    it "assigns user's active tasks as @active_tasks_by_projects" do
      active_task = FactoryGirl.create(:task, assignee: user)
      completed_task = FactoryGirl.create(:task, assignee: user, status: true)
      get :dashboard
      assigns(:active_tasks_by_projects).should eq(active_task.project => [active_task])
    end
  end
end
