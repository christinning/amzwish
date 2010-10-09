require 'nokogiri'
module Amzwish
  class Wishlist
    include Enumerable
    def initialize(email, finder = WishlistFinder.new)
      @email = email
      @finder = finder
    end                 
    
    def books
      to_a
    end
    
    def each
       lists = @finder.find_for(@email)
       has_more_pages = true
       page_num = 1
       while(has_more_pages) do
         html = @finder.get_page(lists[0][:id], page_num)
         page = Nokogiri::HTML(html)  
         page.xpath('//tbody[@class="itemWrapper"]').each do |e| 
           title = e.xpath('.//a[1]/text()').to_s
           asin = e.xpath("@name").to_s.split('.').last
           yield Book.new( title, asin)
         end
         has_more_pages = has_more_pages(page)
         page_num += 1                      
       end
    end
    alias_method :each_book, :each
    
    private
    def has_more_pages(current_page)
      # look and see if the 'Next' at the end of the page is an active link
      current_page.xpath('//div[@class="pagDiv"]/span[@class="pagSide"]/a/span/text()').any?{|t| t.to_s.include?("Next")}
    end
  end
end