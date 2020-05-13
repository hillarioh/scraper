require 'nokogiri'
require 'open-uri'
require_relative '../lib/list_item'

module Lists
  def self.complete_list
    doc = Nokogiri::HTML(URI.parse('https://www.boxofficemojo.com/year/world/2020/?ref_=bo_hm_yrww').open)
    page = 'https://www.boxofficemojo.com'
    rank = 1
    all_list = {}
    doc.css('tr').each do |x|
      x.css('td.mojo-field-type-release_group').each do |y|
        y.css('a').each do |z|
          listed = ListItem.new(rank, y.inner_text, page + z.attr('href'))
          all_list[rank] = listed
        end
        rank += 1
      end
    end
    all_list
  end
end
