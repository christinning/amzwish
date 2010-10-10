require 'spec_helper'
require 'open-uri'

module Amzwish
  describe Wishlist do
    context "empty wishlist" do 
      let(:mock_wrapper){ mock_website_wrapper( %w{ empty.html } ) }
      let(:fixture){ Wishlist.new("address@email.com", mock_wrapper) }
      it "returns an empty list of books" do
        fixture.books.size.should == 0
      end
    end
    
    context "single item wishlist" do
      let(:mock_wrapper){ mock_website_wrapper( %w{ single-item.html } ) }
      let(:fixture){ Wishlist.new("address@email.com", mock_wrapper) }
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
      let(:fixture){ Wishlist.new("address@email.com", mock_wrapper) }
      it "returns a list of books" do
        fixture = Wishlist.new("address@email.com", mock_wrapper)
        fixture.books.size.should be > 0
      end
    end
    
    def mock_website_wrapper(html_files, wishlist_id = "WISHLIST-ID", email = "address@email.com") 
      mock_wrapper = mock(Services::WebsiteWrapper)
      mock_wrapper.should_receive(:find_for).with(email).and_return([{:id=>wishlist_id}]) 
      html_files.each_with_index do |f, i|
        page_num = i+1
        page = open(File.join(PROJECT_DIR, "samples","uk", f )).read
        mock_wrapper.should_receive(:get_page).with( wishlist_id, page_num).and_return(page) 
      end
      mock_wrapper
    end
    
  end
end