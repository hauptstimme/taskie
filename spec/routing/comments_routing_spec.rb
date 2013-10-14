require "spec_helper"

describe CommentsController do
  describe "routing" do
    it "routes to #create" do
      post("/projects/1/tasks/1/comments").should route_to("comments#create", project_id: "1", task_id: "1")
    end
  end
end
