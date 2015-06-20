require 'spec_helper'

describe ProjectsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:project) }

  context "authorized (common)" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "GET show" do
      it "redirects to project tasks" do
        get :show, id: project.id
        expect(response).to redirect_to(project_tasks_path(project.id))
      end
    end

    describe "GET new" do
      it "assigns a new project as @project" do
        get :new
        expect(assigns(:project)).to be_a_new(Project)
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
          expect(assigns(:project)).to be_a(Project)
          expect(assigns(:project)).to be_persisted
        end

        it "redirects to the created project" do
          expect(response).to redirect_to(project_path(Project.last))
        end
      end

      describe "with invalid params" do
        before :each do
          allow_any_instance_of(Project).to receive(:save).and_return(false)
          post :create, project: { "name" => "" }, project_id: project.id
        end

        it "assigns a newly created but unsaved project as @project" do
          expect(assigns(:project)).to be_a_new(Project)
        end

        it "re-renders the 'new' template" do
          expect(response).to render_template("new")
        end
      end
    end
  end

  context "authorized as project owner" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in project.owner
    end

    describe "GET edit" do
      it "assigns the requested project as @project" do
        get :edit, id: project.id
        expect(assigns(:project)).to eq(project)
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested project" do
          expect_any_instance_of(Project).to receive(:update).with({ "name" => "Test Project" })
          put :update, project_id: project.id, id: project.id, project: { "name" => "Test Project" }
        end

        before(:each) { put :update, project_id: project.id, id: project.id, project: valid_attributes }

        it "assigns the requested project as @project" do
          expect(assigns(:project)).to eq(project)
        end

        it "redirects to projects" do
          expect(response).to redirect_to(project_path(project))
        end
      end

      describe "with invalid params" do
        before :each do
          allow_any_instance_of(Project).to receive(:save).and_return(false)
          put :update, project_id: project.id, id: project.id, project: { "name" => "" }
        end

        it "assigns the project as @project" do
          expect(assigns(:project)).to eq(project)
        end

        it "re-renders the 'edit' template" do
          expect(response).to render_template("edit")
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
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "authorized as project participant" do
    before do
      project.users << user
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "GET edit" do
      it "raises an exception" do
        expect {
          get :edit, id: project.id
        }.to raise_exception
      end
    end

    describe "PUT update" do
      it "raises an exception" do
        expect {
          put :update, project_id: project.id, id: project.id, project: { "name" => "Test Project" }
        }.to raise_exception
      end
    end

    describe "DELETE destroy" do
      it "raises an exception" do
        expect {
          delete :destroy, project_id: project.id, id: project.id
        }.to raise_exception
      end
    end
  end

  context "unauthorized" do
    describe "GET show" do
      it "redirects to sign in" do
        get :show, id: project.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET new" do
      it "redirects to sign in" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET edit" do
      it "redirects to sign in" do
        get :edit, id: project.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST create" do
      it "redirects to sign in" do
        post :create, project: valid_attributes
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PUT update" do
      it "redirects to sign in" do
        put :update, project_id: project.id, id: project.id, project: { "name" => "Test Project" }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE destroy" do
      it "redirects to sign in" do
        delete :destroy, project_id: project.id, id: project.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
