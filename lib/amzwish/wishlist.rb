require 'nokogiri'
module Amzwish
  class Wishlist
    def initialize(email, finder)
      @email = email
      @finder = finder
    end                 
    
    def books
      lists = @finder.find_for(@email)
      has_more_pages = true
      books = [] 
      page_num = 1
      while(has_more_pages) do
        page = @finder.get_page(lists[0][:id], page_num)
        doc = Nokogiri::HTML(page)  
        doc.xpath('//tbody[@class="itemWrapper"]').each do |e| 
          name = e.xpath('.//a[1]/text()').to_s
          ref_num = e.xpath("@name").to_s.split('.').last
          books << Book.new( name, ref_num)
        end
        has_more_pages = has_more_pages(doc)
        page_num += 1                      
      end 
      books
    end
    
    def has_more_pages(current_page)
      current_page.xpath('//div[@class="pagDiv"]/span[@class="pagSide"]/a/span/text()').any?{|t| t.to_s.include?("Next")}
    end
  end
end