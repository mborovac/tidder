task :create_users => :environment do
  Post.all.each do |post|
    user = User.find_or_create_by(email:"#{post.creator_name}@tidder.com")
    user.password = SecureRandom.base64
    user.nickname = "#{post.creator_name}"
    if user.save
      puts "Created user #{post.creator_name}"
      post.update(creator_name: user.nickname)
      post.update(user_id: user.id)
    else
      puts "Cannot save user #{post.creator_name}"
    end
  end

  Comment.all.each do |comment|
    user = User.find_or_create_by(email:"#{comment.author_name}@tidder.com")
    user.password = SecureRandom.base64
    user.nickname = "#{comment.author_name}"
    if user.save
      puts "Created user #{comment.author_name}"
      comment.update(author_name: user.nickname)
    else
      puts "Cannot save user #{comment.author_name}"
    end
  end
end
