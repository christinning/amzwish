require 'spec_helper'
require 'open-uri'

module Amzwish
  describe Wishlist do
    describe "finding wishlists" do
      describe "find wishlist by email address where none exists" do 
        it "should return an empty list" do
          mock_wrapper = mock(Services::WebsiteWrapper)
          mock_wrapper.should_receive(:find_for).with("address@email.com").and_return([])
          Wishlist.find("address@email.com", mock_wrapper).should == []
        end
      end
      describe "find wishlist by email address where one found" do 
        it "should return a list with one wishlist" do
          mock_wrapper = mock(Services::WebsiteWrapper)
          mock_wrapper.should_receive(:find_for).with("address@email.com").and_return([Wishlist.new("address@email.com", "WISHLIST-ID", mock_wrapper)])
          lists = Wishlist.find("address@email.com", mock_wrapper)
          lists.size.should == 1
        end
      end
      describe "find wishlist by email address where multiple found" do 
        it "should return a list with one wishlist" do
          mock_wrapper = mock(Services::WebsiteWrapper)
          mock_wrapper.should_receive(:find_for).with("address@email.com").and_return(
            [Wishlist.new("WISHLIST-ID", "WISHLIST-ID", mock_wrapper),
              Wishlist.new("WISHLIST_ID2", "WISHLIST-ID", mock_wrapper)])
          lists = Wishlist.find("address@email.com", mock_wrapper)
          lists.size.should == 2
        end
      end
    end
    
    context "empty wishlist" do 
      let(:mock_wrapper){ mock_website_wrapper( %w{ empty.html } ) }
      let(:fixture){ Wishlist.new("address@email.com", "WISHLIST-ID", mock_wrapper) }
      it "returns an empty list of books" do
        fixture.books.size.should == 0
      end
    end
    
    context "single item wishlist" do
      let(:mock_wrapper){ mock_website_wrapper( %w{ single-item.html } ) }
      let(:fixture){ Wishlist.new("address@email.com", "WISHLIST-ID", mock_wrapper) }
      it "returns a list of books" do
        books = fixture.books
        books.size.should == 1
        books[0].title.should == "Language Myths"     
      end
      
      it "should be enumerable" do
        books = []
        fixture.each_book{|b| books << b}
        books.size.should == 1
      end 
    end
    
    context "multipage wishlist" do
      let(:mock_wrapper){ mock_website_wrapper(%w{ multipage-page1.html multipage-page2.html multipage-page3.html multipage-page4.html}) }
      let(:fixture){ Wishlist.new("address@email.com", "WISHLIST-ID", mock_wrapper) }
      it "returns a list of books" do
        fixture.books.size.should be > 0
      end
    end
    
    def mock_website_wrapper(html_files, wishlist_id = "WISHLIST-ID", email = "address@email.com") 
      mock_wrapper = mock(Services::WebsiteWrapper)
      html_files.each_with_index do |f, i|
        page_num = i+1
        page = open(File.join(PROJECT_DIR, "samples","uk", f )).read
        mock_wrapper.should_receive(:get_page).with( wishlist_id, page_num).and_return(page) 
      end
      mock_wrapper
    end
    
  end
end