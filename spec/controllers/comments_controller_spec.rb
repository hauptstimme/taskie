require 'spec_helper'

describe CommentsController do
  let(:comment) { FactoryGirl.create(:comment) }
  let(:task) { comment.task }
  let(:project) { task.project }
  let(:valid_attributes) { FactoryGirl.attributes_for(:comment) }

  context "authorized" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in comment.user
    end

    describe "GET edit" do
      it "renders the template" do
        xhr :get, :edit, project_id: project.id, task_id: task.id, id: comment.id, format: :js
        expect(response).to render_template("edit")
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Comment" do
          expect {
            post :create, comment: valid_attributes, project_id: project.id, task_id: task.id
          }.to change(Comment, :count).by(1)
        end

        it "assigns a newly created comment as @comment" do
          post :create, comment: valid_attributes, project_id: project.id, task_id: task.id
          expect(assigns(:comment)).to be_a(Comment)
          expect(assigns(:comment)).to be_persisted
        end

        it "redirects to the task" do
          post :create, comment: valid_attributes, project_id: project.id, task_id: task.id
          expect(response).to redirect_to(project_task_path(project, task))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved comment as @comment" do
          allow_any_instance_of(Comment).to receive(:save).and_return(false)
          post :create, comment: { text: "" }, project_id: project.id, task_id: task.id
          expect(assigns(:comment)).to be_a_new(Comment)
        end

        it "redirects to the task" do
          allow_any_instance_of(Comment).to receive(:save).and_return(false)
          post :create, comment: { text: "" }, project_id: project.id, task_id: task.id
          expect(response).to redirect_to(project_task_path(project, task))
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested comment" do
          expect_any_instance_of(Comment).to receive(:update).with({ "text" => "updated text" })
          put :update, project_id: project.id, task_id: task.id, id: comment.id, comment: { "text" => "updated text" }, format: :js
        end

        before(:each) { put :update, project_id: project.id, task_id: task.id, id: comment.id, comment: { "text" => "updated text" }, format: :js }

        it "assigns the requested comment as @comment" do
          expect(assigns(:comment)).to eq(comment)
        end

        it "is successful" do
          expect(response).to be_success
        end
      end

      describe "with invalid params" do
        before :each do
          allow_any_instance_of(Comment).to receive(:save).and_return(false)
          put :update, project_id: project.id, task_id: task.id, id: comment.id, comment: { "text" => "" }, format: :js
        end

        it "assigns the comment as @comment" do
          expect(assigns(:comment)).to eq(comment)
        end

        it "redirects to the task" do
          expect(response).to be_success
        end
      end
    end

    describe "DELETE destroy" do
      before(:each) { comment.save }

      describe "valid time" do
        it "destroys the comment" do
          expect {
            delete :destroy, project_id: project.id, task_id: task.id, id: comment.id
          }.to change{ Comment.count }.by(-1)
        end

        it "redirects to the task" do
          delete :destroy, project_id: project.id, task_id: task.id, id: comment.id
          expect(response).to redirect_to(project_task_path(project, task))
        end
      end

      describe "invalid time" do
        before { Timecop.travel(25.hours.from_now) }

        it "doesn't destroy the comment" do
          expect {
            delete :destroy, project_id: project.id, task_id: task.id, id: comment.id
          }.not_to change{ Comment.count }
        end

        it "redirects to the task" do
          delete :destroy, project_id: project.id, task_id: task.id, id: comment.id
          expect(response).to redirect_to(project_task_path(project, task))
        end
      end
    end
  end

  context "unauthorized" do
    describe "GET edit" do
      it "doesn't render" do
        get :edit, project_id: project.id, task_id: task.id, id: comment.id, format: :js
        expect(response).not_to be_success
      end
    end

    describe "POST create" do
      it "redirects to sign in" do
        post :create, comment: valid_attributes, project_id: project.id, task_id: task.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PUT update" do
      it "doesn't render" do
        put :update, project_id: project.id, task_id: task.id, id: comment.id, comment: { "text" => "updated text" }, format: :js
        expect(response).not_to be_success
      end
    end

    describe "DELETE destroy" do
      it "doesn't render" do
        delete :destroy, project_id: project.id, task_id: task.id, id: comment.id
        expect(response).not_to be_success
      end
    end
  end
end
