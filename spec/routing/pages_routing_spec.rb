require "spec_helper"

describe PagesController do
  describe "routing" do
    it "routes to #dashboard" do
      get("/").should route_to("pages#dashboard")
    end
  end
end
