require 'HTTParty'
require 'Nokogiri'
require 'JSON'
require 'Pry'
require 'csv'

root_url = "https://householdproducts.nlm.nih.gov"
page_array = [*('A'..'Z'), *('0'..'9')]
product_array = []
ingredients_array = []

# get all product names

# page_array.each do |page|
#   page = HTTParty.get("httprs://householdproducts.nlm.nih.gov/cgi-bin/household/list?tbl=TblBrands&alpha=#{page}")
#   parse_page = Nokogiri::HTML(page)
#   parse_page.css('.bodytext ul li a').each do |product|
#     product_array << product.text
#   end
# end

# get all product ingredients

# page_array.each do |page|
#   parsed_page = Nokogiri::HTML(HTTParty.get("https://householdproducts.nlm.nih.gov/cgi-bin/household/list?tbl=TblBrands&alpha=#{page}"))
#   parsed_page.css('.bodytext ul li a').each do |product|
#     inner_parsed_page = Nokogiri::HTML(HTTParty.get(root_url+product.attributes["href"].value))
#     text_elements =  inner_parsed_page.css(".bgtransparent").last.css("tr")
#     text_elements.shift
#
#     file_line = ""
#
#     text_elements.each do |child|
#       file_line += (child.children[0].children.text + ":")
#     end
#
#     puts file_line
#
#     ingredients_array << file_line
#   end
# end


# create product name file

# File.open("product_names.txt", "w+") do |file|
#   file.puts(product_array)
# end

#create ingredient list file
# File.open("ingredient_list.txt", "w+") do |file|
#   file.puts(ingredients_array)
# end
