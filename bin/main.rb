#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require_relative '../lib/listing'

doc = Nokogiri::HTML(open("https://www.boxofficemojo.com/year/world/2020/?ref_=bo_hm_yrww"))


p doc.title
# p doc.table
# p doc.css('title').class
# p doc.css('title')
page = "https://www.boxofficemojo.com"
# Returns movie title of top 20 movies
$safer = []
def valuation(hyper,movie)
    jerry = Nokogiri::HTML(open(hyper))
    jerry.css('tr td a').each do |x| 
        $safer << "#{movie}:#{x.inner_text}"
    end    
end

# 
rank = 1
all_movies = Hash.new
doc.css('tr').each do |x| 
    # valuation(page,x.inner_text)
    x.css('td.mojo-field-type-release_group').each do  |y|
        y.css('a').each do |z|  
            listed = Listing.new(rank,y.inner_text, page + z.attr("href"))
            all_movies[rank]=listed
        end
        # $safer << y.inner_text
        rank +=1
    end 
    # x.css('td.mojo-field-type-money').each do  |z|
    #     p z.inner_text
    # end 
end
# p doc.css('tr').children
# Entering all movie listing to List class using class method
Listing.enter_all(all_movies)
puts "Top movies in 2020"
# all_movies.each_with_index do | k, y| 
#     # p "#{y}. #{k[y+1].movie_name}"
       
# end

print "Movie rank"
puts "\t\t\tMovie name"

p all_movies.count

my_count = 1
shown = 10
loop do
    print "#{all_movies[my_count].rank}."
    puts "\t\t\t#{all_movies[my_count].movie_name}"

    if my_count ==10
        puts "To see more ......... press c or choose movie rank to see its gross returns"
        value = gets.chomp
        if value.downcase == c
            shown = all_movies.count
        else
            break
        end      
    end


    break if my_count == shown
    my_count +=1
end

def see_gross(link)


end

