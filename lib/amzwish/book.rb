module Amzwish
  class Book
    attr_accessor :asin,:title
    def initialize(title, asin)
      @title = title 
      @asin = asin
    end
    
    def ==(other)
      other.respond_to?(:asin) && 
        self.asin == other.asin
    end
    
    def to_s
      "#{title}(#{asin})"
    end
  end
  
end