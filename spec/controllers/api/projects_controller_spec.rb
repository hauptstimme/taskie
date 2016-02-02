require 'spec_helper'

describe Api::ProjectsController do
  let(:project) { FactoryGirl.create(:project) }

  context "authorized" do
    before do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(project.owner.api_key)
    end

    describe "GET index" do
      before(:each) { get :index }

      it "renders successfully" do
        expect(response).to be_success
      end

      it "assigns all projects as @projects" do
        expect(assigns(:projects)).to eq([project])
      end
    end

    describe "GET show" do
      before(:each) { get :show, id: project.to_param }

      it "renders successfully" do
        expect(response).to be_success
      end

      it "assigns the requested project as @project" do
        expect(assigns(:project)).to eq(project)
      end
    end
  end

  context "unauthorized" do
    describe "GET index" do
      before(:each) { get :index }

      it "doesn't render" do
        expect(response).not_to be_success
      end
    end

    describe "GET show" do
      before(:each) { get :show, id: project.to_param }

      it "doesn't render" do
        expect(response).not_to be_success
      end
    end
  end

  # describe "GET new" do
  #   it "assigns a new api_project as @api_project" do
  #     get :new, {}, valid_session
  #     assigns(:api_project).should be_a_new(Api::Project)
  #   end
  # end

  # describe "GET edit" do
  #   it "assigns the requested api_project as @api_project" do
  #     project = Api::Project.create! valid_attributes
  #     get :edit, {:id => project.to_param}, valid_session
  #     assigns(:api_project).should eq(project)
  #   end
  # end

  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new Api::Project" do
  #       expect {
  #         post :create, {:api_project => valid_attributes}, valid_session
  #       }.to change(Api::Project, :count).by(1)
  #     end

  #     it "assigns a newly created api_project as @api_project" do
  #       post :create, {:api_project => valid_attributes}, valid_session
  #       assigns(:api_project).should be_a(Api::Project)
  #       assigns(:api_project).should be_persisted
  #     end

  #     it "redirects to the created api_project" do
  #       post :create, {:api_project => valid_attributes}, valid_session
  #       response.should redirect_to(Api::Project.last)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved api_project as @api_project" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Api::Project.any_instance.stub(:save).and_return(false)
  #       post :create, {:api_project => {  }}, valid_session
  #       assigns(:api_project).should be_a_new(Api::Project)
  #     end

  #     it "re-renders the 'new' template" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Api::Project.any_instance.stub(:save).and_return(false)
  #       post :create, {:api_project => {  }}, valid_session
  #       response.should render_template("new")
  #     end
  #   end
  # end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested api_project" do
  #       project = Api::Project.create! valid_attributes
  #       # Assuming there are no other api_projects in the database, this
  #       # specifies that the Api::Project created on the previous line
  #       # receives the :update_attributes message with whatever params are
  #       # submitted in the request.
  #       Api::Project.any_instance.should_receive(:update).with({ "these" => "params" })
  #       put :update, {:id => project.to_param, :api_project => { "these" => "params" }}, valid_session
  #     end

  #     it "assigns the requested api_project as @api_project" do
  #       project = Api::Project.create! valid_attributes
  #       put :update, {:id => project.to_param, :api_project => valid_attributes}, valid_session
  #       assigns(:api_project).should eq(project)
  #     end

  #     it "redirects to the api_project" do
  #       project = Api::Project.create! valid_attributes
  #       put :update, {:id => project.to_param, :api_project => valid_attributes}, valid_session
  #       response.should redirect_to(project)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the api_project as @api_project" do
  #       project = Api::Project.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Api::Project.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => project.to_param, :api_project => {  }}, valid_session
  #       assigns(:api_project).should eq(project)
  #     end

  #     it "re-renders the 'edit' template" do
  #       project = Api::Project.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Api::Project.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => project.to_param, :api_project => {  }}, valid_session
  #       response.should render_template("edit")
  #     end
  #   end
  # end

  # describe "DELETE destroy" do
  #   it "destroys the requested api_project" do
  #     project = Api::Project.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => project.to_param}, valid_session
  #     }.to change(Api::Project, :count).by(-1)
  #   end

  #   it "redirects to the api_projects list" do
  #     project = Api::Project.create! valid_attributes
  #     delete :destroy, {:id => project.to_param}, valid_session
  #     response.should redirect_to(api_projects_url)
  #   end
  # end
end
