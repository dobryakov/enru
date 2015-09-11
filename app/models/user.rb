class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many   :attempts

  def next_attempt

    next_attempt = nil
    last_attempt = self.attempts.last

    # если попытка уже была, но не завершена
    if !last_attempt.nil? && last_attempt.translated.to_s == ''

      # отдаём эту же попытку снова
      next_attempt = last_attempt

    else

      if last_attempt.nil?
        # create first attempt
        last_phrase_id = 0
      else
        # фраза последней попытки
        last_phrase_id = last_attempt.phrase.id
      end

      # получаем следующую по порядку фразу
      phrase = Phrase.where('id > ?', last_phrase_id).first

      # если фраза нашлась
      unless phrase.nil?
        next_attempt = Attempt.create(
          :user   => self,
          :phrase => phrase
        )
      end

    end

    next_attempt

  end

end
