require 'rubygems'
require 'open-uri'
require 'nokogiri'

def get_the_email_of_a_townhal_from_its_webpage()
	doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/vaureal.html"))
	puts doc.xpath('//td[@class="style27"]/p/ font' )[5]
end
get_the_email_of_a_townhal_from_its_webpage()



def get_all_the_urls_of_val_doise_townhalls()
  doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
   puts doc.xpath('//').each do |link|
end
get_all_the_urls_of_val_doise_townhalls()
