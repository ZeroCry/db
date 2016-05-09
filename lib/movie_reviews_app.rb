class MovieReviewsApp
  # Put your code here !
  	attr_accessor :tweet
  	@tweet = {}

	def self.call(*args)
		@arguments = args;	
		@arguments.each do |argument|
			map_titles(argument)
			map_information(argument)
		end

		final_tweets = concatenate(reduce(@tweet))

		return final_tweets		
	end 

	def self.map_titles(information)
		@information = JSON.parse(information)
		# Map Titles
		@information.each do |info_hash|
			unless @tweet.has_key?(info_hash['title'])
				@tweet[info_hash['title']] = []			
			end	
	 	end	

	end

	def self.map_information(information)
		@information = JSON.parse(information)
	 	@tweet.keys.each do |key| #Iterate over all the keys of the Tweet, this is an array
			@information.each do |info| #Iterate over all the 
				if info['title'] == key	
					info.each do | k, v|
						unless @tweet[key].include?(v)
						   @tweet[key] <<  {k => v} 
						end
					end
				end
			end
		end
	end

	def self.reduce(tweet)
		tweet.each do |k, v|
			tweet[k] = [v.reduce({}, :merge)]
		end
	end


	def self.concatenate(information)
		tweets = build_tweet(information)
		return tweets
	end

	def self.check_year(year)
		unless year.nil?
			return year =  " (#{year.to_s})"	
		end
	end

	def self.build_tweet(input)
		tweet = input
		tweets = []

		tweet.each do |k , y|
			y.each do |v|

				title = v['title'] 
				year = check_year(v['year'])
				review = v['review']
				score = get_stars(v['score'])
				tweet = "#{title}#{year}: #{review} #{score}"


				while check(tweet) do
					title = check_title(title, tweet)	
					tweet = "#{title}#{year}: #{review} #{score}"
					review = check_review(review, tweet)
				end
				tweets << tweet
			end
		end
		return tweets
	end

	def self.check(tweet)
		if tweet.length > 140
			return true
		end
	end

	def self.check_title(title, tweet)
		if title.length > 24
			title = title[0..24]
		end
		return title
	end

	def self.check_review(review, tweet)
		if check(tweet)
			return review[0..(review.length - (tweet.length - 139))]	
		end	
	end

	def self.get_stars(value)

		stars = ''

		int_value = value / 20
		float_value = value.to_f / 20
		result = float_value - int_value 

		(1..int_value).each do 
			stars << '★'
		end

		if result <= 0.5 && result != 0 
			stars <<  "½"
		else
			if float_value < 5 
				stars << '★'
			end
		end

		return stars
	end

	

end




