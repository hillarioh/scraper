class SaleItem
  attr_reader :opening, :gross, :region, :release_date, :country

  def initialize(region, country, release_date, opening, gross)
    @region = region
    @country = country
    @release_date = release_date
    @opening = opening
    @gross = gross
  end
end
