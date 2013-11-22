require "spec_helper"

describe Api::TasksController do
  describe "routing" do
    it "routes to #index" do
      get("/api/projects/1/tasks").should route_to("api/tasks#index", project_id: "1", format: :json)
    end

    it "routes to #show" do
      get("/api/projects/1/tasks/93").should route_to("api/tasks#show", project_id: "1", id: "93", format: :json)
    end
  end
end
