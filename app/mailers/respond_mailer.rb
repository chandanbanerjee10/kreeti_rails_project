class RespondMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.respond_mailer.respond_to_candidate.subject
  #
  def respond_to_candidate(object)
    @post = object
    @job = @post.job
    @candidate = @post.user
    @recruiter = @post.job.user
    mail to: @candidate.email, subject: "Congratulations on this Job Offer", from: @recruiter.email
  end

  def reject_candidate(object)
    @post = object
    @job = @post.job
    @candidate = @post.user
    @recruiter = @post.job.user
    mail to: @candidate.email, subject: "Your Job Application to #{@job.organisation_name}", from: @recruiter.email
  end
end
