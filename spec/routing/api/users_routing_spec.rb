require "spec_helper"

describe Api::UsersController do
  describe "routing" do
    it "routes to #show" do
      expect(get("/api/users/93")).to route_to("api/users#show", id: "93", format: :json)
    end
  end
end
