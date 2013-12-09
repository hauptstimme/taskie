require "spec_helper"

describe Api::MilestonesController do
  describe "routing" do
    it "routes to #index" do
      get("/api/projects/1/milestones").should route_to("api/milestones#index", project_id: "1", format: :json)
    end

    it "routes to #show" do
      get("/api/projects/1/milestones/93").should route_to("api/milestones#show", project_id: "1", id: "93", format: :json)
    end
  end
end
