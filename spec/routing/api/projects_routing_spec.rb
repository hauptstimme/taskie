require "spec_helper"

describe Api::ProjectsController do
  describe "routing" do
    it "routes to #index" do
      expect(get("/api/projects")).to route_to("api/projects#index", format: :json)
    end

    it "routes to #show" do
      expect(get("/api/projects/93")).to route_to("api/projects#show", id: "93", format: :json)
    end
  end
end
