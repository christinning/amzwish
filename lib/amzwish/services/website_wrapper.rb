require 'rest_client'
module Amzwish
  module Services
    class WebsiteWrapper
      FIND_WISHLIST_URL = "http://www.amazon.co.uk/gp/registry/search.html?ie=UTF8&type=wishlist"
      DISPLAY_WISHLIST_URL_TEMPLATE = "http://www.amazon.co.uk/registry/wishlist/%s"
      
      def initialize(rest_client = RestClientWrapper.new)
        @rest_client = rest_client
      end            

      def find_for(email)
        resp = @rest_client.post(email)
        # If a user has a single public wishlist then should get a redirect to it
        if (resp[:code] == 302)
          /(?:\?|&)id=(\w*)/ =~ resp[:headers][:location]
          wishlist_id = $~[1]
          [Wishlist.new(email, wishlist_id, self)]
        else
          []
        end
      end

      def get_page(wishlist_id, page=1)
        @rest_client.get(wishlist_id, page)
      end
    end
    
    class RestClientWrapper
      def post(email)
        r = RestClient.post( WebsiteWrapper::FIND_WISHLIST_URL, "field-name" => email ) do |resp, req, result| 
          {:code => resp.code, :headers=>resp.headers}
        end
      end

      def get(wishlist_id, page)
        url = generate_url_for_wishlist(wishlist_id)
        params = { :page => page, :_encoding => 'UTF8', :filter => '3', :sort=> 'date-added',
          :layout => 'compact', :reveal => 'unpurchased'}
        RestClient.get( url, :params => params ) do |resp, req, result|
          raise "could not find wishlist" unless resp.code == 200 
          resp.body
        end
      end

      private 
      def generate_url_for_wishlist(id)
        sprintf(WebsiteWrapper::DISPLAY_WISHLIST_URL_TEMPLATE, id)
      end    
    end
  end
end