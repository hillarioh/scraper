require 'nokogiri'
require 'open-uri'

class Movie
   def initialize(doc)
        @docs = doc
    end

    def get_movie_title
        movie_title = @docs.at_xpath('//*[@id="a-page"]/main/div/div[1]/div[1]/div/div/div[2]/h1').inner_text
        return "MOVIE TITLE: #{movie_title}"
    end

    def get_movie_description
        movie_desc = @docs.at_xpath('//*[@id="a-page"]/main/div/div[1]/div[1]/div/div/div[2]/p').inner_text
        return "MOVIE DESCRIPTION: #{movie_desc}"
    end

    def get_thumb
        page = "https://www.boxofficemojo.com"
        page += @docs.at_xpath('//*[@id="title-summary-refiner"]/a').attr('href')

        my_details = Nokogiri::HTML(open(page))

        running_time = my_details.xpath('//*[@id="a-page"]/main/div/div[3]/div[4]/div[6]/span[2]').inner_text
        
        distributor = my_details.xpath('//*[@id="a-page"]/main/div/div[3]/div[4]/div[1]/span[2]/text()').inner_text

        return "Time: #{running_time}\t\t\tDistributor: #{distributor}"
        
    end

    
end