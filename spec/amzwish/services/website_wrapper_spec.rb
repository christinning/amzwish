require 'spec_helper'

module Amzwish
  module Services 
    PREVENT_WEB_REQUESTS = false
  
    describe WebsiteWrapper do 
    
      let(:mock_client){ mock("rest_client")}
      let(:fixture){ WebsiteWrapper.new(mock_client) }
       
      describe "getting wishlist id" do
        describe "wishlist not found" do
          it "should return an empty array" do
            mock_client.should_receive(:post).with("address@email.com").and_return({:code => 200})
            fixture.find_for("address@email.com").should == []
          end
        end
        describe "single wishlist found" do
          it "should return an array with one wishlist" do
            mock_client.should_receive(:post).with("address@email.com").and_return(
              { :code => 302, 
                :headers=> {
                  :location=>"http://www.amazon.co.uk/gp/registry/registry.html/276-3987950-0414363?ie=UTF8&type=wishlist&id=WISH_LIST_ID"}
                  })
            result = fixture.find_for("address@email.com")
            result.size.should == 1
            result[0].class.should == Wishlist
          end
        end
      end
    
      describe "getting wishlist content html" do
        describe "getting page 1" do
          it "should return the page as a string" do
            mock_client.should_receive(:get).with("WISH_LIST_ID", 1).and_return("Page Content")
            fixture.get_page("WISH_LIST_ID", 1).should == "Page Content"
          end
        end    
      end 
    
      context "examples that make actual web requests" do 
        let(:fixture){ WebsiteWrapper.new() }
        example "get wishlist html" do
          fixture.get_page("34VGL4IX1RMYO", 1).should =~ /Chris Tinning/
        end
        example "get wishlist" do
          fixture.find_for("chris.tinning@gmail.com")[0].list_id.should == "34VGL4IX1RMYO" 
        end
      end unless PREVENT_WEB_REQUESTS                          
    end
  end           
end