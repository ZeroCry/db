class MovieReviewsApp 
  attr_accessor :tweet
  @tweet = Hash.new()

  def self.call(*args)
    args.map{|a| JSON.parse(a).map{|i|  append(i['title'], i)}} 
    return build_tweet(@tweet)	
  end  

  def self.append(title, hash)
    @tweet[title].merge!(hash) rescue @tweet[title] = hash
  end

  def self.build_tweet(input)
    tweet, tweets = input, [] 
    tweet.each do |k, v|   
      t, r, s = v['title'], v['review'], get_stars(v['score']) 
      y = " (#{v['year'].to_s})" if v['year']  
      tweet = "#{t}#{y}: #{r} #{s}"
      tweet = "#{t[0..24]}#{y}: #{r} #{s}" if tweet.length > 140  
      tweet = "#{t[0..24]}#{y}: #{r[0..((139 + (r.length - tweet.length)))]} #{s}" if tweet.length >= 140
      tweets << tweet 
    end
    return tweets
  end 

  def self.get_stars(n)    
    starts_partial =  (n % 20).between?(1,10) ? "½" : "★"
    return (n % 20) == 0 ? '★' * (n / 20).to_i  : ('★' * (n / 20).to_i) + starts_partial  
  end 
end
 