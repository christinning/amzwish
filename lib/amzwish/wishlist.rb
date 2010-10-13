require 'nokogiri'
module Amzwish
  class Wishlist
    include Enumerable
    
    attr_accessor :list_id, :email
    
    class << self
      def find(email, website = Services::WebsiteWrapper.new) 
        website.find_for(email)
      end
    end
    
    def initialize(email,  wishlist_id = "WISHLIST-ID", website = Services::WebsiteWrapper.new)
      @email = email
      @website = website
      @list_id = wishlist_id
    end                 
    
    def books
      to_a
    end
    
    def each
       each_page{|p| p.books.each{|b| yield b}}
    end
    alias_method :each_book, :each
    
    private
    def each_page
      has_more_pages = true
      page_num = 1
      while(has_more_pages) do
        page =  Page.new(@website.get_page(@list_id, page_num))
        yield page 
        has_more_pages = page.has_next?
        page_num += 1                      
      end
    end 
    
    class Page
      def initialize(html)
        @page = Nokogiri::HTML(html)
      end
      
      def has_next?
        # look and see if the 'Next' at the end of the page is an active link
        @page.xpath('//div[@class="pagDiv"]/span[@class="pagSide"]/a/span/text()').any?{|t| t.to_s.include?("Next")}
      end
      
      def books
        @page.xpath('//tbody[@class="itemWrapper"]').collect do |e| 
          title = e.xpath('.//a[1]/text()').to_s
          asin = e.xpath("@name").to_s.split('.').last
          Book.new( title, asin)
        end
      end
    end
  end
end