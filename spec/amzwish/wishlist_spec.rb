require 'spec_helper'

module Amzwish
  describe Wishlist do
    context "wishlist with one book on it" do
      it "returns the book" do
        fixture = Wishlist.new("my@email.com")
        fixture.books.should == [Book.new("Alice in Wonderland", "123")]
      end
    end
  
  end
end