require 'spec_helper'

module Amzwish 
  PREVENT_WEB_REQUESTS = true
  
  describe WishlistFinder do 
    
    let(:mock_client){ mock("rest_client")}
    let(:fixture){ WishlistFinder.new(mock_client) }
       
    describe "getting wishlist id" do
      describe "wishlist not found" do
        it "should return an empty array" do
          mock_client.should_receive(:post).with("my@email.com").and_return({:code => 200})
          fixture.find_for("my@email.com").should == []
        end
      end
      describe "single wishlist found" do
        it "should return an array with one hash" do
          mock_client.should_receive(:post).with("chris.tinning@gmail.com").and_return(
            { :code => 302, 
              :headers=> {
                :location=>"http://www.amazon.co.uk/gp/registry/registry.html/276-3987950-0414363?ie=UTF8&type=wishlist&id=34VGL4IX1RMYO"}
                })
          fixture.find_for("chris.tinning@gmail.com").should == [{:id=>"34VGL4IX1RMYO"}]
        end
      end
    end
    
    describe "getting wishlist content html" do
      describe "getting page 1" do
        it "should return the page as a string" do
          mock_client.should_receive(:get).with("WISH-LIST-ID", 1).and_return("Page Content")
          fixture.get_page("WISH-LIST-ID", 1).should == "Page Content"
        end
      end    
    end 
    
    context "examples that make actual web requests" do
      example "get wishlist html" do
        fixture = WishlistFinder.new(WishlistFinder::RestClientWrapper.new)
        fixture.get_page("34VGL4IX1RMYO", 1).should =~ /Chris Tinning/
      end
      example "get wishlist id" do
        fixture = WishlistFinder.new(WishlistFinder::RestClientWrapper.new)
        fixture.find_for("chris.tinning@gmail.com").should == [{:id=>"34VGL4IX1RMYO"}]
      end
    end unless PREVENT_WEB_REQUESTS
                              
  end           
end