require "spec_helper"

describe PagesController do
  describe "routing" do
    it "routes to #dashboard" do
      expect(get("/")).to route_to("pages#dashboard")
    end
  end
end
