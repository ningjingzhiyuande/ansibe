require "spec_helper"

describe EntretainsController do
  describe "routing" do

    it "routes to #index" do
      get("/entretains").should route_to("entretains#index")
    end

    it "routes to #new" do
      get("/entretains/new").should route_to("entretains#new")
    end

    it "routes to #show" do
      get("/entretains/1").should route_to("entretains#show", :id => "1")
    end

    it "routes to #edit" do
      get("/entretains/1/edit").should route_to("entretains#edit", :id => "1")
    end

    it "routes to #create" do
      post("/entretains").should route_to("entretains#create")
    end

    it "routes to #update" do
      put("/entretains/1").should route_to("entretains#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/entretains/1").should route_to("entretains#destroy", :id => "1")
    end

  end
end
