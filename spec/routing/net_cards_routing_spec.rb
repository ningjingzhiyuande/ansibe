require "spec_helper"

describe NetCardsController do
  describe "routing" do

    it "routes to #index" do
      get("/net_cards").should route_to("net_cards#index")
    end

    it "routes to #new" do
      get("/net_cards/new").should route_to("net_cards#new")
    end

    it "routes to #show" do
      get("/net_cards/1").should route_to("net_cards#show", :id => "1")
    end

    it "routes to #edit" do
      get("/net_cards/1/edit").should route_to("net_cards#edit", :id => "1")
    end

    it "routes to #create" do
      post("/net_cards").should route_to("net_cards#create")
    end

    it "routes to #update" do
      put("/net_cards/1").should route_to("net_cards#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/net_cards/1").should route_to("net_cards#destroy", :id => "1")
    end

  end
end
