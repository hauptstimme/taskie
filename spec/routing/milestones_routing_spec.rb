require "spec_helper"

describe MilestonesController do
  describe "routing" do
    it "routes to #new" do
      get("/projects/1/milestones").should route_to("milestones#index", project_id: "1")
    end

    it "routes to #show" do
      get("/projects/1/milestones/2").should route_to("milestones#show", project_id: "1", id: "2")
    end

    it "routes to #new" do
      get("/projects/1/milestones/new").should route_to("milestones#new", project_id: "1")
    end

    it "routes to #create" do
      post("/projects/1/tasks/2/comments").should route_to("comments#create", project_id: "1", task_id: "2")
    end

    it "routes to #edit" do
      get("/projects/1/tasks/2/comments/3/edit").should route_to("comments#edit", project_id: "1", task_id: "2", id: "3")
    end

    it "routes to #update" do
      put("/projects/1/tasks/2/comments/3").should route_to("comments#update", project_id: "1", task_id: "2", id: "3")
    end

    it "routes to #destroy" do
      delete("/projects/1/tasks/2/comments/3").should route_to("comments#destroy", project_id: "1", task_id: "2", id: "3")
    end
  end
end
