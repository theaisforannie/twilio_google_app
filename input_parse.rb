str = $stdin.gets.chomp.downcase
new_str = str.gsub(' ', '%20')

base = "https://www.google.com/search?q="
search_results = base << new_str

puts search_results