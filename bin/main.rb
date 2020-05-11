#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'

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

doc.css('tr td.mojo-field-type-release_group a').each do |x| 
    page += x.attr("href")
    valuation(page,x.inner_text)
end
# p doc.css('tr').children


puts $safer