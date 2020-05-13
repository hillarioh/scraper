class ListItem
  attr_reader :rank, :movie_name, :link

  def initialize(rank, name, link)
    @rank = rank
    @movie_name = name
    @link = link
  end
end
