require 'nokogiri'
require 'open-uri'
load '../keys.rb'

SAMPLE_DIR="uk"
PAGE_1 = "34VGL4IX1RMYO?reveal=unpurchased&filter=all&sort=date-added&layout=compact"
PAGE_2 = "ref=cm_wl_sortbar_o_n_page_4?_encoding=UTF8&filter=all&sort=date-added&layout=compact&reveal=unpurchased&page=4"
PAGE_3 = "ref=cm_wl_sortbar_o_page_2?_encoding=UTF8&filter=all&sort=date-added&layout=compact&reveal=unpurchased&page=2"
PAGE_4 = "ref=cm_wl_sortbar_o_page_3?_encoding=UTF8&filter=all&sort=date-added&layout=compact&reveal=unpurchased&page=3"
                                                                                                                         
doc = Nokogiri::HTML(open(File.join(SAMPLE_DIR, PAGE_1)))  
doc.xpath('//tbody[@class="itemWrapper"]').each do |e| 
  name = e.xpath('.//a[1]/text()').to_s
  ref_num = e.xpath("@name").to_s.split('.').last
  p "#{ref_num} : #{name}"
end