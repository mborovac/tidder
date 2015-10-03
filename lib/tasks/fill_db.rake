require 'net/http'
require 'json'

REDDIT_URL = 'www.reddit.com'

task :download_subreddits => :environment do
  response_json = Net::HTTP.get_response(REDDIT_URL,'/reddits.json?sort=hot\'')
  return if response_json.code != '200'

  parsed_json = JSON.parse(response_json.body)
  parsed_json['data']['children'].first(10).each do |entry|
    data = entry['data']
    puts "Fetching subreddit #{data['display_name']}"
    Subreddit.find_or_create_by(name: data['display_name']) do |subreddit|
      subreddit.title = data['title']
      subreddit.description = data['description'].truncate(500)
      unless subreddit.save
        puts "Cannot save #{subreddit.name}:"
        puts subreddit.errors.full_messages
      end
    end
  end
end

task :download_subreddit_posts_and_comments => :download_subreddits do
  Subreddit.all.each do |subreddit|
    puts "Fetching posts for subreddit #{subreddit.name}"
    download_posts(subreddit)
  end
  puts "Done"
end

def download_posts(subreddit)
  response_json = Net::HTTP.get_response(REDDIT_URL,"/r/#{subreddit.name}/new.json?sort=new")
  return if response_json.code != '200'

  parsed_json = JSON.parse(response_json.body)
  parsed_json['data']['children'].first(10).each do |post|
    data = post['data']
    post = Post.new(subreddit: subreddit, title: data['title'], creator_name: data['author'])
    post.content = data['selftext'].blank? ? data['url'] : data['selftext']
    if post.save
      download_comments(post, data['permalink'])
    else
      puts "Cannot save post:"
      puts post.errors.full_messages
    end
  end
end

def download_comments(post, permalink)
  response_json = Net::HTTP.get_response(REDDIT_URL, "#{permalink}.json")
  return if response_json.code != '200'

  parsed_json = JSON.parse(response_json.body)
  parsed_json[1]['data']['children'].each do |comment|
    data = comment['data']
    comment = Comment.new(post: post, content: data['body'], author_name: data['author'])
    if !comment.save
      puts "Cannot save comment:"
      puts comment.errors.full_messages
    end
  end
end
