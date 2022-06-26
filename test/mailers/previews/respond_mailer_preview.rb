# Preview all emails at http://localhost:3000/rails/mailers/respond_mailer
class RespondMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/respond_mailer/respond_to_candidate
  def respond_to_candidate
    post = Post.all.sample
    RespondMailer.respond_to_candidate(post)
  end

end
