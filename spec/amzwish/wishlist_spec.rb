require 'spec_helper'
require 'open-uri'

module Amzwish
  describe Wishlist do
    context "empty wishlist" do
      it "returns an empty list of books" do
        mock_finder = mock(WishlistFinder)
        mock_finder.should_receive(:find_for).with("address@email.com").and_return([{:id=>"WISHLIST-ID"}])
        empty_page = open(File.join(PROJECT_DIR, "samples","uk","empty.html")).read
        mock_finder.should_receive(:get_page).with("WISHLIST-ID", 1).and_return(empty_page)
        fixture = Wishlist.new("address@email.com", mock_finder)
        fixture.books.size.should == 0
      end
    end
    
    context "single item wishlist" do
      it "returns a list of books" do
        mock_finder = mock(WishlistFinder)
        mock_finder.should_receive(:find_for).with("address@email.com").and_return([{:id=>"WISHLIST-ID"}])
        page = open(File.join(PROJECT_DIR, "samples","uk","single-item.html")).read
        mock_finder.should_receive(:get_page).with("WISHLIST-ID", 1).and_return(page)
        fixture = Wishlist.new("address@email.com", mock_finder)
        books = fixture.books
        books.size.should == 1
        books[0].title.should == "Language Myths"
        
      end 
    end
    
    context "multipage wishlist" do
      it "returns a list of books" do
        mock_finder = mock(WishlistFinder)
        mock_finder.should_receive(:find_for).with("address@email.com").and_return([{:id=>"WISHLIST-ID"}]) 
        page1 = open(File.join(PROJECT_DIR, "samples","uk","multipage-page1.html")).read
        page2 = open(File.join(PROJECT_DIR, "samples","uk","multipage-page2.html")).read
        page3 = open(File.join(PROJECT_DIR, "samples","uk","multipage-page3.html")).read
        page4 = open(File.join(PROJECT_DIR, "samples","uk","multipage-page4.html")).read
        mock_finder.should_receive(:get_page).with("WISHLIST-ID", 1).and_return(page1)
        mock_finder.should_receive(:get_page).with("WISHLIST-ID", 2).and_return(page2)
        mock_finder.should_receive(:get_page).with("WISHLIST-ID", 3).and_return(page3)
        mock_finder.should_receive(:get_page).with("WISHLIST-ID", 4).and_return(page4)
        fixture = Wishlist.new("address@email.com", mock_finder)
        fixture.books.size.should be > 0
      end
    end
  end
end