require 'HTTParty'
require 'Nokogiri'
require 'JSON'
require 'Pry'
require 'csv'

root_url = "http://www.ewg.org/skindeep/"
page_array = [*('A'..'Z'), *('0'..'9')]
product_array = []
ingredients_array = []

# get all product names and ingredients_array

#loop through each sub menu
  #loop through each #click_next_number > a
    #for each of these pages, grab h1 and put it into the product name file, then grab all the #Ingredients > .product_tables > tr > td > a.text and store them in ingredients separated by :
  #end
#end

page_array.each do |page|
  parsed_page = Nokogiri::HTML(HTTParty.get("https://householdproducts.nlm.nih.gov/cgi-bin/household/list?tbl=TblBrands&alpha=#{page}"))
  parsed_page.css('.bodytext ul li a').each do |product|
    inner_parsed_page = Nokogiri::HTML(HTTParty.get(root_url+product.attributes["href"].value))
    text_elements =  inner_parsed_page.css(".bgtransparent").last.css("tr")
    text_elements.shift

    file_line = ""

    text_elements.each do |child|
      file_line += (child.children[0].children.text + ":")
    end

    puts file_line

    ingredients_array << file_line
  end
end


# create product name file

# File.open("product_names.txt", "w+") do |file|
#   file.puts(product_array)
# end

#create ingredient list file
File.open("ingredient_list.txt", "w+") do |file|
  file.puts(ingredients_array)
end
