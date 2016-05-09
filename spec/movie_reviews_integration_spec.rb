require "movie_reviews_app"
require 'json'

describe "integration" do
  let(:reviews_json) {
    <<-JSON
      [
        {"title":"Star Wars","review":"Great, this film was","score":77},
        {"title":"Star Wars The Force Awakens","review":"A long time ago in a galaxy far far away someone made the best sci-fi film of all time. Then some chap came along and basically made the same movie again","score":50},
        {"title":"Metropolis","review":"Another movie about a robot. Very strong futuristic look. But also very very old. Hard to understand what was happening because the audio was too low","score":15},
        {"title":"Dr. Strangelove or How I Learned to Stop Worrying and Love the Bomb","review":"Hilarious Kubrick satire","score":100},
        {"title":"Plan 9 from outer space","review":"So bad it's bad","score":7}
      ]
    JSON
  }

  let(:movies_json) {
    <<-JSON
      [
        {"title":"Star Wars","year":1977},
        {"title":"Star Wars The Force Awakens","year":2015},
        {"title":"Dr. Strangelove or How I Learned to Stop Worrying and Love the Bomb","year":1964},
        {"title":"Plan 9 from outer space","year":1959}
      ]
    JSON
  }

  before do
    @results = MovieReviewsApp.call(reviews_json, movies_json)
  end

  describe MovieReviewsApp do
    it "Formats the star wars review correctly" do
      expect(@results[0]).to eq "Star Wars (1977): Great, this film was ★★★★"
    end

    it "Formats the star wars: the force awakens review correctly" do
      expect(@results[1]).to eq "Star Wars The Force Awake (2015): A long time ago in a galaxy far far away someone made the best sci-fi film of all time. Then some chap ★★½"
    end

    it "Formats the Metropolis review correctly" do
      expect(@results[2]).to eq "Metropolis: Another movie about a robot. Very strong futuristic look. But also very very old. Hard to understand what was happening becaus ★"
    end

    it "Formats the Dr. Strangelve review correctly" do
      expect(@results[3]).to eq "Dr. Strangelove or How I Learned to Stop Worrying and Love the Bomb (1964): Hilarious Kubrick satire ★★★★★"
    end

    it "Formats the Plan 9 from outer space review correctly" do
      expect(@results[4]).to eq "Plan 9 from outer space (1959): So bad it's bad ½"
    end
  end
end
