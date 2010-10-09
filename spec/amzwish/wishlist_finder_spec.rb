require 'spec_helper'

module Amzwish 
  PREVENT_WEB_REQUESTS = true
  
  describe WishlistFinder do    
    describe "querying for wishlists by email" do
      describe "wishlist not found" do
        it "should return an empty array" do
          mock_client = mock("rest_client")
          mock_client.should_receive(:post).with("my@email.com").and_return({:code => 200})
          fixture = WishlistFinder.new(mock_client)
          fixture.find_for("my@email.com").should == []
        end
      end
      describe "single wishlist found" do
        it "should return an array with one hash" do
          mock_client = mock("rest_client")
          mock_client.should_receive(:post).with("chris.tinning@gmail.com").and_return(
            { :code => 302, 
              :headers=> {
                :location=>"http://www.amazon.co.uk/gp/registry/registry.html/276-3987950-0414363?ie=UTF8&type=wishlist&id=34VGL4IX1RMYO"}
                })
          fixture = WishlistFinder.new(mock_client)
          fixture.find_for("chris.tinning@gmail.com").should == [{:id=>"34VGL4IX1RMYO"}]
        end
        context "making an actual web request" do
          it "should return an array with one hash" do
            fixture = WishlistFinder.new(WishlistFinder::RestClientWrapper.new)
            fixture.find_for("chris.tinning@gmail.com").should == [{:id=>"34VGL4IX1RMYO"}]
          end
        end unless PREVENT_WEB_REQUESTS
      end
    end
    
    describe "getting wishlist html" do
      describe "getting page 1" do
        it "should return the page as a string" do
          mock_client = mock("rest_client")
          mock_client.should_receive(:get).with("WISHLISTID", 1).and_return("Page Content")
          fixture = WishlistFinder.new(mock_client)
          fixture.get_page("WISHLISTID", 1).should == "Page Content"
        end
      end 
      context "making an actual web request" do
        it "should return the page as a string" do
          fixture = WishlistFinder.new(WishlistFinder::RestClientWrapper.new)
          fixture.get_page("34VGL4IX1RMYO", 1).should =~ /Chris Tinning/
        end
      end unless PREVENT_WEB_REQUESTS    
    end                           
  end           
end