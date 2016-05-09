## Data

We've got the following data

- `data/reviews.json` - captured via an online survey tool, this file has the list of all new employee reviews we have yet to tweet about
- `data/movies.json` - this file contains a list of the movies we've watched, and information about that movie

## Requirements

- Read in the list of reviews
- Read in the list of movies
- For each review, output a "tweet" of that review, which should follow these rules:
  - Tweets should follow the format `Movie Title (year): Review of the movie ★★★★½`
  - If the year cannot be found, it should be omitted
  - Tweets may not have more than 140 characters
  - If the tweet would go over this limit, titles should be trimmed to 25 characters
  - If the tweet is still over the limit, then the review text should be shortened too until it is exactly 140 characters
  - The score should be presented as Unicode stars, using a "five star rating" with halves

(see `spec/movie_reviews_integration_spec.rb` for specific details and edge cases)

## Getting Started

You will require ruby and bundler to be installed to run through this exercise. Once installed, ensure the dependencies are installed by running `bundle`.

Once installed, you should be able to run the following commands:

- `bundle exec rake`  : Runs the application and prints the output to the terminal
- `bundle exec rspec` : Runs the test suite; there are some integration specs to get you started, but you'll probably want to add more as you work

