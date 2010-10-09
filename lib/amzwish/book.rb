module Amzwish
  class Book
    attr_accessor :asin,:name
    def initialize(name, asin)
      @name = name 
      @asin = asin
    end
    
    def ==(other)
      other.respond_to?(:asin) && 
        self.asin == other.asin
    end
  end
  
end