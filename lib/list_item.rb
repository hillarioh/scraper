class ListItem
    attr_reader  :rank,:movie_name,:link
    attr_accessor :all_listings

    def initialize(rank,name,link)
        @rank = rank
        @movie_name = name
        @link = link
        @all_listings = nil        
    end

end