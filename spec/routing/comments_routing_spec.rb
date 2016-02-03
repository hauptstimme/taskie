require "spec_helper"

describe CommentsController do
  describe "routing" do
    it "routes to #create" do
      expect(post("/projects/1/tasks/2/comments"))
        .to route_to("comments#create", project_id: "1", task_id: "2")
    end

    it "routes to #edit" do
      expect(get("/projects/1/tasks/2/comments/3/edit"))
        .to route_to("comments#edit", project_id: "1", task_id: "2", id: "3")
    end

    it "routes to #show" do
      expect(get("/projects/1/tasks/2/comments/3"))
        .to route_to("comments#show", project_id: "1", task_id: "2", id: "3")
    end

    it "routes to #update" do
      expect(put("/projects/1/tasks/2/comments/3"))
        .to route_to("comments#update", project_id: "1", task_id: "2", id: "3")
    end

    it "routes to #destroy" do
      expect(delete("/projects/1/tasks/2/comments/3"))
        .to route_to("comments#destroy", project_id: "1", task_id: "2", id: "3")
    end
  end
end
