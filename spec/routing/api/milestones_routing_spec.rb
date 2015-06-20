require "spec_helper"

describe Api::MilestonesController do
  describe "routing" do
    it "routes to #index" do
      expect(get("/api/projects/1/milestones")).to route_to("api/milestones#index", project_id: "1", format: :json)
    end

    it "routes to #show" do
      expect(get("/api/projects/1/milestones/93")).to route_to("api/milestones#show", project_id: "1", id: "93", format: :json)
    end
  end
end
