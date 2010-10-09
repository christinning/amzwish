require 'rest_client'
module Amzwish
  class WishlistFinder
    def initialize(rest_client)
      @rest_client = rest_client
    end            
    
    def find_for(email)
      resp = @rest_client.post(email)
      if (resp[:code] == 302)
        /(\?|&)id=(?<wishlist_id>\w*)/ =~ resp[:headers][:location]
        [{:id => wishlist_id}]
      else
        []
      end
    end
    
    
  end
end