require 'HTTParty'
require 'Nokogiri'
require 'JSON'
require 'Pry'
require 'csv'

ROOT_URL = "http://www.ewg.org"
page_array = [*('A'..'Z'), *('0'..'9')]
product_array = []
ingredients_array = []

#scrape for new page change nth child

#get home page
parsed_page = Nokogiri::HTML(HTTParty.get(ROOT_URL + "/skindeep"))
parsed_page.css(".menuhover:nth-child(3) > .sub > .row a").each do |link|
  #get inner category page (i.e. sunscreen)
  inner_parsed_page = Nokogiri::HTML(HTTParty.get(ROOT_URL + link.attributes["href"].value))
  #loop through each page by pressing next until next doesn't exist
  while true
    inner_parsed_page.css(".product_name_list a").each do |product|
      product_page = Nokogiri::HTML(HTTParty.get(ROOT_URL + product.attributes["href"].value))
      product_array << product_page.css("h1").text
      # puts product_page.css("h1").text
      specific_products = product_page.css(".firstcol a")
      
      ingredient_line = ""
      
      for i in 0..specific_products.length - 2
        unless specific_products[i].text.include?(".com") || specific_products[i].text.include?(".ca")|| specific_products[i].text.include?("www.")
          ingredient_line = ingredient_line + specific_products[i].text + ":"
        end
      end

      ingredients_array << ingredient_line
    end
    
    counter = 0
    #check if next page exists
    inner_parsed_page.css("#click_next_number a").each do |next_page|
      if next_page.text == " Next>"
        inner_parsed_page = Nokogiri::HTML(HTTParty.get(ROOT_URL + next_page.attributes["href"].value))
        counter += 1
      end
    end
    
    if counter == 0
      break
    end
  end
end

#create product name file
File.open("product_names_makeup.txt", "w+") do |file|
  file.puts(product_array)
end

#create ingredient list file
File.open("ingredient_list_makeup.txt", "w+") do |file|
  file.puts(ingredients_array)
end
