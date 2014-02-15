class UserMailer < ActionMailer::Base
  default from: "evie@sch.gr"
  
  def notification_mail(user, book)
    @user = user
    @book = book
    mail(to: @user.email, subject: 'Delayed return of the book')
  end
  
end
