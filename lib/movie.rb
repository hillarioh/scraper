require 'nokogiri'
require 'open-uri'

class Movie
  def initialize(doc)
    @docs = doc
  end

  def movie_title
    movie_title = @docs.at_xpath('//*[@id="a-page"]/main/div/div[1]/div[1]/div/div/div[2]/h1').inner_text
    "MOVIE TITLE: #{movie_title}"
  end

  def movie_description
    movie_desc = @docs.at_xpath('//*[@id="a-page"]/main/div/div[1]/div[1]/div/div/div[2]/p').inner_text
    "MOVIE DESCRIPTION: #{movie_desc}"
  end

  def thumb
    page = 'https://www.boxofficemojo.com'
    page += @docs.at_xpath('//*[@id="title-summary-refiner"]/a').attr('href')

    my_details = Nokogiri::HTML(URI.parse(page).open)

    running_time = my_details.xpath('//*[@id="a-page"]/main/div/div[3]/div[4]/div[6]/span[2]').inner_text

    distributor = my_details.xpath('//*[@id="a-page"]/main/div/div[3]/div[4]/div[1]/span[2]/text()').inner_text

    "Other: #{running_time}\t\t\tDistributor: #{distributor}"
  end
end
