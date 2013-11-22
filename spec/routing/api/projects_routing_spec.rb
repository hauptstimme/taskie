require "spec_helper"

describe Api::ProjectsController do
  describe "routing" do
    it "routes to #index" do
      get("/api/projects").should route_to("api/projects#index", format: :json)
    end

    it "routes to #show" do
      get("/api/projects/93").should route_to("api/projects#show", id: "93", format: :json)
    end
  end
end
