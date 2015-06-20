require "spec_helper"

describe TasksController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/projects/1/tasks")).to route_to("tasks#index", project_id: "1")
    end

    it "routes to #new" do
      expect(get("/projects/1/tasks/new")).to route_to("tasks#new", project_id: "1")
    end

    it "routes to #show" do
      expect(get("/projects/1/tasks/1")).to route_to("tasks#show", project_id: "1", id: "1")
    end

    it "routes to #edit" do
      expect(get("/projects/1/tasks/1/edit")).to route_to("tasks#edit", project_id: "1", id: "1")
    end

    it "routes to #follow" do
      expect(get("/projects/1/tasks/1/follow")).to route_to("tasks#follow", project_id: "1", id: "1")
    end

    it "routes to #create" do
      expect(post("/projects/1/tasks")).to route_to("tasks#create", project_id: "1")
    end

    it "routes to #update" do
      expect(put("/projects/1/tasks/1")).to route_to("tasks#update", project_id: "1", id: "1")
    end

    it "routes to #destroy" do
      expect(delete("/projects/1/tasks/1")).to route_to("tasks#destroy", project_id: "1", id: "1")
    end

  end
end
