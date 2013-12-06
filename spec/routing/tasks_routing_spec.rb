require "spec_helper"

describe TasksController do
  describe "routing" do

    it "routes to #index" do
      get("/projects/1/tasks").should route_to("tasks#index", project_id: "1")
    end

    it "routes to #new" do
      get("/projects/1/tasks/new").should route_to("tasks#new", project_id: "1")
    end

    it "routes to #show" do
      get("/projects/1/tasks/1").should route_to("tasks#show", project_id: "1", id: "1")
    end

    it "routes to #edit" do
      get("/projects/1/tasks/1/edit").should route_to("tasks#edit", project_id: "1", id: "1")
    end

    it "routes to #follow" do
      get("/projects/1/tasks/1/follow").should route_to("tasks#follow", project_id: "1", id: "1")
    end

    it "routes to #create" do
      post("/projects/1/tasks").should route_to("tasks#create", project_id: "1")
    end

    it "routes to #update" do
      put("/projects/1/tasks/1").should route_to("tasks#update", project_id: "1", id: "1")
    end

    it "routes to #destroy" do
      delete("/projects/1/tasks/1").should route_to("tasks#destroy", project_id: "1", id: "1")
    end

  end
end
