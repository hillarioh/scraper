class Location

    #may contain 
    attr_reader :region,:country
    def initialize(region,country)
        @region = region
        @country = country
    end
    
end