require 'spec_helper'                    
require 'open-uri'

module Amzwish
  describe Wishlist::Page do
    describe "an empty page" do
      let(:fixture){ create_page_from("empty.html") }
      it "should not have another page" do
        fixture.should_not be_has_next
      end
      
      it "should_not_have_any_books" do
        fixture.books.should be_empty
      end
    end  
    describe "the first page of many" do
      let(:fixture){ create_page_from("multipage-page1.html") }
      it "should have another page" do 
        fixture.should be_has_next
      end
      it "should have books on it" do
        fixture.books.should_not be_empty
      end
      
      it "should have iterable books" do
        books = fixture.books
      end
    end
    
    describe "the last page of many" do
      let(:fixture){ create_page_from("multipage-page4.html") }
      it "should not have another page" do 
        fixture.should_not be_has_next
      end
    end
    
    describe "the a page with one item on it" do
      let(:fixture){ create_page_from("single-item.html") }
      it "should return the correct book" do 
        fixture.books[0].should == Book.new("Language Myths", "0140260234")
      end
    end
    
    
    def create_page_from(html_file)
      Wishlist::Page.new(open(File.join(PROJECT_DIR, "samples", "uk", html_file))) 
    end
  end
end