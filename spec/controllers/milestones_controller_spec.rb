require 'spec_helper'

describe MilestonesController do
  let(:milestone) { FactoryGirl.create(:milestone) }
  let(:project) { milestone.project }
  let(:valid_attributes) { FactoryGirl.attributes_for(:milestone) }

  context "authorized" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in milestone.project.owner
    end

    describe "GET index" do
      it "assigns milestones as @milestones" do
        get :index
        assigns(:milestones).should = [milestone]
      end
    end

    describe "GET show" do
      it "assigns the requested milestone as @milestone" do
        get :show, project_id: project, id: milestone
        assigns(:milestone).should eq(milestone)
      end
    end

    describe "GET new" do
      it "assigns a new milestone as @milestone" do
        get :new, project_id: project.id
        assigns(:milestone).should be_a_new(Milestone)
      end
    end

    describe "GET edit" do
      it "assigns the requested milestone as @milestone" do
        get :edit, project_id: project.id, id: milestone.id
        assigns(:milestone).should eq(milestone)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Milestone" do
          expect {
            post :create, milestone: valid_attributes, project_id: project.id
          }.to change(Milestone, :count).by(1)
        end

        before(:each) { post :create, milestone: valid_attributes, project_id: project.id }

        it "assigns a newly created milestone as @milestone" do
          assigns(:milestone).should be_a(Milestone)
          assigns(:milestone).should be_persisted
        end

        it "redirects to the created milestone" do
          response.should redirect_to(project_milestone_path(project, Milestone.last))
        end
      end

      describe "with invalid params" do
        before :each do
          Milestone.any_instance.stub(:save).and_return(false)
          post :create, milestone: { "title" => "" }, project_id: project.id
        end

        it "assigns a newly created but unsaved milestone as @milestone" do
          assigns(:milestone).should be_a_new(Milestone)
        end

        it "re-renders the 'new' template" do
          response.should render_template("new")
        end
      end
    end

    describe "PATCH update" do
      it "updates the milestone" do
        Milestone.any_instance.should_receive(:update).with({ "title" => "new" })
        patch :update, project_id: project.id, id: milestone.id, milestone: { "title" => "new" }, format: :js
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested milestone" do
          Milestone.any_instance.should_receive(:update).with({ "title" => "Test Milestone" })
          put :update, project_id: project.id, id: milestone.id, milestone: { "title" => "Test Milestone" }
        end

        before(:each) { put :update, project_id: project.id, id: milestone.id, milestone: valid_attributes }

        it "assigns the requested milestone as @milestone" do
          assigns(:milestone).should eq(milestone)
        end

        it "redirects to the milestone" do
          response.should redirect_to(project_milestone_path(project, milestone))
        end
      end

      describe "with invalid params" do
        before :each do
          Milestone.any_instance.stub(:save).and_return(false)
          put :update, project_id: project.id, id: milestone.id, milestone: { "title" => "" }
        end

        it "assigns the milestone as @milestone" do
          assigns(:milestone).should eq(milestone)
        end

        it "re-renders the 'edit' template" do
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      before { milestone.save }

      it "destroys the requested milestone" do
        expect {
          delete :destroy, project_id: project.id, id: milestone.id
        }.to change(Milestone, :count).by(-1)
      end

      it "redirects to the milestones list" do
        delete :destroy, project_id: project.id, id: milestone.id
        response.should redirect_to(project_milestones_path(project))
      end
    end
  end

  context "unauthorized" do
    describe "GET index" do
      it "redirects to sign in" do
        get :index, project_id: project
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "GET show" do
      it "redirects to sign in" do
        get :show, project_id: project, id: milestone
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "GET new" do
      it "redirects to sign in" do
        get :new, project_id: project.id
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "GET edit" do
      it "redirects to sign in" do
        get :edit, project_id: project.id, id: milestone.id
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "POST create" do
      it "redirects to sign in" do
        post :create, project_id: project.id, milestone: { "title" => "" }
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "PUT update" do
      it "redirects to sign in" do
        put :update, project_id: project.id, id: milestone.id, milestone: { "title" => "" }
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "DELETE destroy" do
      it "redirects to sign in" do
        delete :destroy, project_id: project.id, id: milestone.id
        response.should redirect_to(new_user_session_path)
      end
    end
  end
end
