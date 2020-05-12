#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require_relative '../lib/listing'
require_relative '../lib/sales'

doc = Nokogiri::HTML(open("https://www.boxofficemojo.com/year/world/2020/?ref_=bo_hm_yrww"))


p doc.title
page = "https://www.boxofficemojo.com"
# Returns movie title of top 20 movies

rank = 1
all_movies = Hash.new
doc.css('tr').each do |x| 
    x.css('td.mojo-field-type-release_group').each do  |y|
        y.css('a').each do |z|  
            listed = Listing.new(rank,y.inner_text, page + z.attr("href"))
            all_movies[rank]=listed
        end
        rank +=1
    end 
end

# Entering all movie listing to List class using class method
Listing.enter_all(all_movies)
puts "Top movies in 2020"

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
        if value.downcase == 'c'
            shown = all_movies.count
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
        link = all_movies[choice].link
        see_gross(link)
    else
        puts "wrong input"
        choose_movie(limit)
    end
    
end

choose_movie(shown)

def see_gross(link)

    doc = Nokogiri::HTML(open(link))

    movie_title = doc.at_xpath('//*[@id="a-page"]/main/div/div[1]/div[1]/div/div/div[2]/h1').inner_text
    movie_desc = doc.at_xpath('//*[@id="a-page"]/main/div/div[1]/div[1]/div/div/div[2]/p').inner_text
    puts movie_title
    puts movie_desc

    # Region-domestic - test here may return a nilClass
    table_value = 1
    all_sales = []
    4.times do
        path = '//*[@id="a-page"]/main/div/div[4]/div/div/table[' + "#{table_value.to_s}" +"]"    
        region, country, r_date, opening, gross = nil
        doc.xpath(path).each do |k| 
            region = k.at_css('/tr[1]/th').inner_text
            k.css('tr').each do |n|
                table_def =1
                n.css('td').each do |n|
                    case table_def
                    when 1
                        country = n.inner_text
                    when 2
                        r_date = n.inner_text
                    when 3
                        opening = n.inner_text
                    else
                        gross = n.inner_text
                    end
                    table_def +=1
                end
                all_sales << Sale.new(region,country,r_date,opening,gross)
            end
        end
        table_value +=1
    end

    return all_sales

end

puts see_gross.count

