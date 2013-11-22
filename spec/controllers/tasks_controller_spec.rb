require 'spec_helper'

describe TasksController do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, owner: user) }
  let(:task) { FactoryGirl.create(:task, project: project) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:task) }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "GET index" do
    before do
      tasks = Array.new(11) do |n|
        FactoryGirl.create(:task, project: project, name: "Test Task #{n}")
      end
    end

    before(:each) { get :index, project_id: project.id }

    it "assigns paginated tasks as @tasks" do
      assigns(:tasks).size.should == 10
    end
  end

  describe "GET show" do
    it "assigns the requested task as @task" do
      get :show, project_id: project.id, id: task.id
      assigns(:task).should eq(task)
    end
  end

  describe "GET new" do
    it "assigns a new task as @task" do
      get :new, project_id: project.id
      assigns(:task).should be_a_new(Task)
    end
  end

  describe "GET edit" do
    it "assigns the requested task as @task" do
      get :edit, project_id: project.id, id: task.id
      assigns(:task).should eq(task)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Task" do
        expect {
          post :create, task: valid_attributes, project_id: project.id
        }.to change(Task, :count).by(1)
      end

      before(:each) { post :create, task: valid_attributes, project_id: project.id }

      it "assigns a newly created task as @task" do
        assigns(:task).should be_a(Task)
        assigns(:task).should be_persisted
      end

      it "redirects to the created task" do
        response.should redirect_to(project_task_path(project, Task.last))
      end
    end

    describe "with invalid params" do
      before :each do
        Task.any_instance.stub(:save).and_return(false)
        post :create, task: { "name" => "" }, project_id: project.id
      end

      it "assigns a newly created but unsaved task as @task" do
        assigns(:task).should be_a_new(Task)
      end

      it "re-renders the 'new' template" do
        response.should render_template("new")
      end
    end
  end

  describe "PATCH update" do
    it "updates the task" do
      Task.any_instance.should_receive(:update).with({ "status" => true })
      patch :update, project_id: project.id, id: task.id, task: { "status" => true }, format: :js
    end

    it "creates task activity" do
      expect {
        patch :update, project_id: project.id, id: task.id, task: { "status" => true }, format: :js
      }.to change{ task.activities.count }.by(1)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested task" do
        Task.any_instance.should_receive(:update).with({ "name" => "Test Task" })
        put :update, project_id: project.id, id: task.id, task: { "name" => "Test Task" }
      end

      before(:each) { put :update, project_id: project.id, id: task.id, task: valid_attributes }

      it "assigns the requested task as @task" do
        assigns(:task).should eq(task)
      end

      it "redirects to the task" do
        response.should redirect_to(project_task_path(project, task))
      end
    end

    describe "with invalid params" do
      before :each do
        Task.any_instance.stub(:save).and_return(false)
        put :update, project_id: project.id, id: task.id, task: { "name" => "" }
      end

      it "assigns the task as @task" do
        assigns(:task).should eq(task)
      end

      it "re-renders the 'edit' template" do
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before { task.save }

    it "destroys the requested task" do
      expect {
        delete :destroy, project_id: project.id, id: task.id
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      delete :destroy, project_id: project.id, id: task.id
      response.should redirect_to(project_tasks_path(project))
    end
  end
end
