class ParserAction
  # require Nokogiri
  require 'open-uri'
  
  
  NAMES_URL = "http://imiona.nazwiska-polskie.pl/meskie"
  NAZWISKAS_URL = "http://nazwiska-polskie.pl/lista/"
  TABLICE_URL = "https://pl.wikisource.org/wiki/Polskie_tablice_rejestracyjne"
  
  def first_name
    page = Nokogiri::XML(open(NAMES_URL))
    count = page.css("tr").count
    rate = 0
    name = nil
    loop do
      randed = rand(count)
      tr = page.css("tr")[randed]
      rate = tr.children[1].css(".bar")[0].attributes['style'].value.scan(/\d/).join('')[0..3].to_i
      
      if rate > 150
        name = tr.children[2].text
        break
      end
    end
    
    name
  end
  
  def last_name
    random_letter = ('A'..'Z').to_a.shuffle.first.to_s
    url = NAZWISKAS_URL+random_letter
    page = Nokogiri::XML(open(NAZWISKAS_URL+random_letter))
    randed = rand(page.css('strong').count)
    page.css('strong')[randed].text
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def car_number
    page = Nokogiri::XML(open(TABLICE_URL))
    randed = rand(page.css('ul:first').css('li').count)
    page.css('#mw-content-text ul:last').css('li')[randed].text
  end
end