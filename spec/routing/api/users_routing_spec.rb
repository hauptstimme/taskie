require "spec_helper"

describe Api::UsersController do
  describe "routing" do
    it "routes to #show" do
      get("/api/users/93").should route_to("api/users#show", id: "93", format: :json)
    end
  end
end
