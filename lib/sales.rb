require 'nokogiri'
require 'open-uri'

class Sale
  def initialize(doc)
    @doc = doc
  end

  def domestic_sales
    domestic = @doc.xpath('//*[@id="a-page"]/main/div/div[3]/div[1]/div/div[1]/span[2]/a/span').inner_text
    international = @doc.xpath('//*[@id="a-page"]/main/div/div[3]/div[1]/div/div[2]/span[2]/span').inner_text
    total = @doc.xpath('//*[@id="a-page"]/main/div/div[3]/div[1]/div/div[3]/span[2]/span').inner_text

    "DOMESTIC(USA) Returns: #{domestic}\tInternational Returns: #{international}\tTotal Returns: #{total}"
  end

  def sales
    table_value = 1
    all_sales = []
    4.times do
      path = '//*[@id="a-page"]/main/div/div[4]/div/div/table[' + table_value.to_s + ']'
      region, country, r_date, opening, gross = nil
      @doc.xpath(path).each do |k|
        region = k.at_css('/tr[1]/th').inner_text
        table_row = 0
        k.css('tr').each do |n|
          table_row += 1
          next if table_row == 1
          next if table_row == 2

          country = n.css('/td[1]').inner_text.downcase
          r_date = n.css('td[2]').inner_text.downcase.gsub(/\n\s+/, '')
          opening = n.css('td[3]').inner_text.downcase.gsub(/\n\s+/, '')
          gross = n.css('td[4]').inner_text.downcase.gsub(/\n\s+/, '')
          all_sales << SaleItem.new(region, country, r_date, opening, gross)
        end
      end
      table_value += 1
    end
    all_sales
  end
end
