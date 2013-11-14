require 'spec_helper'

describe ProjectsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, owner: user) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:project) }

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "GET index" do
    before(:each) { get :index }

    it "assigns projects as @projects" do
      assigns(:projects).should eq([project])
    end
  end

  describe "GET show" do
    it "redirects to project tasks" do
      get :show, id: project.id
      response.should redirect_to(project_tasks_path(project.id))
    end
  end

  describe "GET new" do
    it "assigns a new project as @project" do
      get :new
      assigns(:project).should be_a_new(Project)
    end
  end

  describe "GET edit" do
    it "assigns the requested project as @project" do
      get :edit, id: project.id
      assigns(:project).should eq(project)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Project" do
        expect {
          post :create, project: valid_attributes
        }.to change(Project, :count).by(1)
      end

      before(:each) { post :create, project: valid_attributes }

      it "assigns a newly created project as @project" do
        assigns(:project).should be_a(Project)
        assigns(:project).should be_persisted
      end

      it "redirects to the created project" do
        response.should redirect_to(projects_path)
      end
    end

    describe "with invalid params" do
      before :each do
        Project.any_instance.stub(:save).and_return(false)
        post :create, project: { "name" => "" }, project_id: project.id
      end

      it "assigns a newly created but unsaved project as @project" do
        assigns(:project).should be_a_new(Project)
      end

      it "re-renders the 'new' template" do
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested project" do
        Project.any_instance.should_receive(:update).with({ "name" => "Test Project" })
        put :update, project_id: project.id, id: project.id, project: { "name" => "Test Project" }
      end

      before(:each) { put :update, project_id: project.id, id: project.id, project: valid_attributes }

      it "assigns the requested project as @project" do
        assigns(:project).should eq(project)
      end

      it "redirects to projects" do
        response.should redirect_to(projects_path)
      end
    end

    describe "with invalid params" do
      before :each do
        Project.any_instance.stub(:save).and_return(false)
        put :update, project_id: project.id, id: project.id, project: { "name" => "" }
      end

      it "assigns the project as @project" do
        assigns(:project).should eq(project)
      end

      it "re-renders the 'edit' template" do
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before { project.save }

    it "destroys the requested project" do
      expect {
        delete :destroy, project_id: project.id, id: project.id
      }.to change(Project, :count).by(-1)
    end

    it "redirects to the projects list" do
      delete :destroy, project_id: project.id, id: project.id
      response.should redirect_to(projects_path)
    end
  end
end
