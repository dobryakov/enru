class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many   :attempts

  def next_attempt

    next_attempt = nil
    last_attempt = self.attempts.last

    if last_attempt.nil?
      # create first attempt
      last_attempt_id = 0
    else
      last_attempt_id = last_attempt.id
    end

    phrase = Phrase.where('id > ?', last_attempt_id).first

    unless phrase.nil?
      next_attempt = Attempt.create(
        :user   => self,
        :phrase => phrase
      )
    end

    next_attempt

  end

end
