#!/usr/bin/env ruby
require_relative '../lib/lists'
require_relative '../lib/movie'
require_relative '../lib/sales'
require_relative '../lib/sale_item'

$all_movies = Lists.get_list

puts "Top movies in 2020"

print "Movie rank"
puts "\t\t\tMovie name"

my_count = 1
shown = 10
loop do
    print "#{all_movies[my_count].rank}."
    puts "\t\t\t#{all_movies[my_count].movie_name}"

    if my_count ==10
        puts "To see more ......... press c or choose movie rank to see its gross returns"
        value = gets.chomp
        if value.downcase == 'c'
            shown = $all_movies.count
        else
            break
        end      
    end
    break if my_count == shown
    my_count +=1
end

def choose_movie(limit)
    puts "Pick a movie to see its 2020 gross"
    choice = gets.chomp.to_i
    if choice.positive? && choice <= limit
        link =$all_movies[choice].link
        return link
    else
        puts "wrong input"
        choose_movie(limit)
    end
    
end

def see_gross(link)

    doc = Nokogiri::HTML(open(link))

    new_movie = Movie.new(doc)
    puts new_movie.get_movie_title
    puts new_movie.get_movie_description
    puts new_movie.get_thumb

    new_sale = Sale.new(doc)
    new_sale.get_domestic_sales
    return new_sale.get_sales    

end

# Calling the methods - chained choose_movie inside see_gross method
 arry = see_gross(choose_movie(shown))

# puts see_gross.count
puts "Search for movie gross by country: "
check = gets.chomp.downcase

puts "country\t\t\trelease date\t\t\tOpening\t\t\tGross"
arry.each do |n|
    if (n.country =~  /\A#{check}/) == 0
        print "#{n.country}\t\t\t" 
        print "#{n.release_date}\t\t\t"
        print "#{n.opening}\t\t\t"
        puts "#{n.gross}"
    end
end



