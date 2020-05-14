require_relative '../lib/movie'
require_relative '../lib/lists'
require_relative '../lib/sale_item'
require_relative '../lib/list_item'
require_relative '../lib/sales'
require 'nokogiri'
require 'open-uri'

describe Sale do
    let(:doc){Nokogiri::HTML(URI.parse('https://www.boxofficemojo.com/releasegroup/gr3944174085/?ref_=bo_ydw_table_1').open) }
    let(:new_sale) { Sale.new(doc) }
    describe '#initialize' do
        it 'Html document should not be empty' do
            expect(doc).to_not eql(nil)
        end
    end
    describe '#sale' do
        it 'Should return an  array list of sales'  do
            expect((new_sale.sales).size).to_not eql(0)
        end  
    end
    describe '#domestic_sales' do
        it 'Should never be empty' do
            expect(new_sale.domestic_sales).to_not eql(nil)
        end
    end
end

describe Movie do
    let(:doc){Nokogiri::HTML(URI.parse('https://www.boxofficemojo.com/releasegroup/gr3944174085/?ref_=bo_ydw_table_1').open) }
    let(:new_movie) { Movie.new(doc) }
    describe '#initialize' do
        it 'Html document should not be empty' do
            expect(doc).to_not eql(nil)
        end
    end
    describe '#movie_title' do
        it 'Should never be empty' do
            expect(new_movie.movie_title).to_not eql(nil)
        end
    end
    describe '#movie_description' do
        it 'Should never be empty' do
            expect(new_movie.movie_description).to_not eql(nil)
        end
    end
    describe '#thumb' do
        it 'Should never be empty' do
            expect(new_movie.thumb).to_not eql(nil)
        end
    end

    
end

describe Lists do
    describe '#complete_list' do
        it 'Should not return empty hash' do
            expect((Lists.complete_list).count).to_not eql(0)
        end        
    end
end