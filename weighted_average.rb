require 'open-uri'
require 'json'

weighted_rent = 0
weighted_total_rent = 0
weighted_size = 0

result = JSON.parse(open("http://mock-data.spacelist.ca/suites").read)
cities = []
result.each { |obj| cities << obj["city"] }

cities.uniq!
cities.each do |city| 
  result.each do |obj|
    if obj["city"] == city
      weighted_rent = obj["rent"] * obj["size"]
      weighted_size += obj["size"]
      weighted_total_rent += weighted_rent
    end
  end
  weighted_average = weighted_total_rent / weighted_size
  puts "#{city} - #{weighted_average}"
  weighted_size = 0
  weighted_total_rent = 0
  weighted_rent = 0
end