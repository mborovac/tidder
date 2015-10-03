class Notifications < ApplicationMailer

  def comments(user, post, comment)
    user = user
    post = post
    @comment = comment
    mail(to: user.email, subject: "#{post.title} - New Comment")
  end

end
