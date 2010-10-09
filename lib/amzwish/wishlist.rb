module Amzwish
  class Wishlist
    def initialize(email)
      
    end                 
    
    def books
      return [Book.new("Alice in Wonderland", "123")]
    end
    
  end
end