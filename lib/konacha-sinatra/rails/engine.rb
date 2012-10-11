module Rails

  class Engine

    def self.method_missing(sym, *args, &block)
    end
    
    def self.const_missing(*args)
    end

    def method_missing(sym, *args, &block)
    end

    def self.config
      @config ||= OpenStruct.new
      return @config
    end
    
  end
  
end