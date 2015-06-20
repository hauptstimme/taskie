require "spec_helper"

describe Api::TasksController do
  describe "routing" do
    it "routes to #index" do
      expect(get("/api/projects/1/tasks")).to route_to("api/tasks#index", project_id: "1", format: :json)
    end

    it "routes to #show" do
      expect(get("/api/projects/1/tasks/93")).to route_to("api/tasks#show", project_id: "1", id: "93", format: :json)
    end
  end
end
