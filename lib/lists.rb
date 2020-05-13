require 'nokogiri'
require 'open-uri'
require_relative '../lib/list_item'

module Lists

    def initialize
        @doc = Nokogiri::HTML(open("https://www.boxofficemojo.com/year/world/2020/?ref_=bo_hm_yrww"))
        @page = "https://www.boxofficemojo.com"                       
    end

    def Lists.get_list
        rank = 1
        all_list = Hash.new
        @doc.css('tr').each do |x| 
            x.css('td.mojo-field-type-release_group').each do  |y|
                y.css('a').each do |z|  
                    listed = ListItem.new(rank,y.inner_text, @page + z.attr("href"))
                    all_list[rank]=listed
                end
                rank +=1
            end 
        end
        return all_list
    end

end