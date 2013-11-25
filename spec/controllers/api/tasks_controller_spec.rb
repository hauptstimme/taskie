require 'spec_helper'

describe Api::TasksController do
  let(:task) { FactoryGirl.create(:task) }

  context "authorized" do
    before do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(task.project.owner.api_key)
    end

    describe "GET index" do
      before(:each) { get :index, project_id: task.project.to_param }

      it "renders successfully" do
        response.should be_success
      end

      it "assigns all tasks as @tasks" do
        assigns(:tasks).should eq([task])
      end
    end

    describe "GET show" do
      before(:each) { get :show, project_id: task.project.to_param, id: task.to_param }

      it "renders successfully" do
        response.should be_success
      end

      it "assigns the requested task as @task" do
        assigns(:task).should eq(task)
      end
    end
  end

  context "unauthorized" do
    describe "GET index" do
      before(:each) { get :index, project_id: task.project.to_param }

      it "doesn't render" do
        response.should_not be_success
      end
    end

    describe "GET show" do
      before(:each) { get :show, project_id: task.project.to_param, id: task.to_param }

      it "doesn't render" do
        response.should_not be_success
      end
    end
  end

  # describe "GET new" do
  #   it "assigns a new api_task as @api_task" do
  #     get :new, {}, valid_session
  #     assigns(:api_task).should be_a_new(Api::Task)
  #   end
  # end

  # describe "GET edit" do
  #   it "assigns the requested api_task as @api_task" do
  #     task = Api::Task.create! valid_attributes
  #     get :edit, {:id => task.to_param}, valid_session
  #     assigns(:api_task).should eq(task)
  #   end
  # end

  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new Api::Task" do
  #       expect {
  #         post :create, {:api_task => valid_attributes}, valid_session
  #       }.to change(Api::Task, :count).by(1)
  #     end

  #     it "assigns a newly created api_task as @api_task" do
  #       post :create, {:api_task => valid_attributes}, valid_session
  #       assigns(:api_task).should be_a(Api::Task)
  #       assigns(:api_task).should be_persisted
  #     end

  #     it "redirects to the created api_task" do
  #       post :create, {:api_task => valid_attributes}, valid_session
  #       response.should redirect_to(Api::Task.last)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved api_task as @api_task" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Api::Task.any_instance.stub(:save).and_return(false)
  #       post :create, {:api_task => {  }}, valid_session
  #       assigns(:api_task).should be_a_new(Api::Task)
  #     end

  #     it "re-renders the 'new' template" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Api::Task.any_instance.stub(:save).and_return(false)
  #       post :create, {:api_task => {  }}, valid_session
  #       response.should render_template("new")
  #     end
  #   end
  # end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested api_task" do
  #       task = Api::Task.create! valid_attributes
  #       Api::Task.any_instance.should_receive(:update).with({ "these" => "params" })
  #       put :update, {:id => task.to_param, :api_task => { "these" => "params" }}, valid_session
  #     end

  #     it "assigns the requested api_task as @api_task" do
  #       task = Api::Task.create! valid_attributes
  #       put :update, {:id => task.to_param, :api_task => valid_attributes}, valid_session
  #       assigns(:api_task).should eq(task)
  #     end

  #     it "redirects to the api_task" do
  #       task = Api::Task.create! valid_attributes
  #       put :update, {:id => task.to_param, :api_task => valid_attributes}, valid_session
  #       response.should redirect_to(task)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the api_task as @api_task" do
  #       task = Api::Task.create! valid_attributes
  #       Api::Task.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => task.to_param, :api_task => {  }}, valid_session
  #       assigns(:api_task).should eq(task)
  #     end

  #     it "re-renders the 'edit' template" do
  #       task = Api::Task.create! valid_attributes
  #       Api::Task.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => task.to_param, :api_task => {  }}, valid_session
  #       response.should render_template("edit")
  #     end
  #   end
  # end

  # describe "DELETE destroy" do
  #   it "destroys the requested api_task" do
  #     task = Api::Task.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => task.to_param}, valid_session
  #     }.to change(Api::Task, :count).by(-1)
  #   end

  #   it "redirects to the api_tasks list" do
  #     task = Api::Task.create! valid_attributes
  #     delete :destroy, {:id => task.to_param}, valid_session
  #     response.should redirect_to(api_tasks_url)
  #   end
  # end

end
