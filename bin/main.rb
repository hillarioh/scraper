#!/usr/bin/env ruby
require_relative '../lib/lists'
require_relative '../lib/movie'
require_relative '../lib/sales'
require_relative '../lib/sale_item'

module Main
  ALL_MOVIES = Lists.complete_list

  def self.movie_rank
    puts 'Top movies in 2020'
    print 'Movie rank'
    puts "\tMovie name"

    my_count = 1
    shown = 5
    loop do
      print "#{ALL_MOVIES[my_count].rank}."
      puts "\t#{ALL_MOVIES[my_count].movie_name}"
      if my_count == 5
        puts 'Enter c to show full list or any key  to move to the next step'
        value = gets.chomp
        value.downcase == 'c' ? shown = ALL_MOVIES.count : break
      end
      break if my_count == shown

      my_count += 1
    end

    shown
  end

  def self.choose_movie(limit)
    puts 'Enter a movie rank to see its 2020 gross'
    choice = gets.chomp.to_i
    if choice.positive? && choice <= limit
      link = ALL_MOVIES[choice].link
      link
    else
      puts "invalid input(enter value between 1-#{limit}) "
      choose_movie(limit)
    end
  end

  def self.see_gross(link)
    doc = Nokogiri::HTML(URI.parse(link).open)

    new_movie = Movie.new(doc)
    puts new_movie.movie_title
    puts new_movie.movie_description
    puts new_movie.thumb

    new_sale = Sale.new(doc)
    puts new_sale.domestic_sales
    new_sale.sales
  end

  def self.sale_search(arry)
    raise 'Empty array' if arry.empty?

    puts 'Search for movie gross by country: '
    check = gets.chomp.downcase

    puts "country\t\t\trelease date\t\t\tOpening\t\t\tGross"

    count = 0
    arry.each do |n|
      next unless n.country =~ /\A#{check}/

      count += 1
    end
    search_results(arry, count, check)
  end

  def self.search_results(arry, count, check)
    puts "You have #{count} matches"
    arry.each do |n|
      next unless n.country =~ /\A#{check}/

      print "#{n.country}\t\t\t"
      print "#{n.release_date}\t\t\t"
      print "#{n.opening}\t\t\t"
      puts n.gross.to_s
    end
  end
end

arry = Main.see_gross(Main.choose_movie(Main.movie_rank))
Main.sale_search(arry)
