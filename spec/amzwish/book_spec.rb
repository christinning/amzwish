require 'spec_helper'
 
module Amzwish
  describe Book do
    describe "equality" do
      let(:fixture){ Book.new("Title", "123") }
      describe "is based on asin number" do
        example "books with the same asin number are equal" do
          (fixture == Book.new("Title", "123")).should == true
        end
        example "books with different asin numbers are not equal" do
          (fixture == Book.new("Title", "321")).should == false 
        end
        example "books are not equal to things that are not books" do
          (fixture == "Title").should == false
        end
      end
    end
  end           
end