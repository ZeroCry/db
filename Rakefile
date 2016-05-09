require 'json'

task :default => [:run]

desc "pretty print review tweets generated from reviews and movies json"
task "run" do
  $LOAD_PATH.unshift(File.dirname(__FILE__), "lib")
  require 'movie_reviews_app'

  # load the data files into strings for you
  reviews_json = File.read("data/reviews.json")
  movies_json = File.read("data/movies.json")

  # call the app, passing the data as strings containing JSON
  results = MovieReviewsApp.call(reviews_json, movies_json)

  # pretty print the output
  puts "Tweets:"
  puts "-------"
  puts results.join("\n")
end
