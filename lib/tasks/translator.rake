namespace :translator do

  desc "Translate"
  task translate: :environment do

    limit = 1 # @TODO .env
    translator = Yandex::Translator.new(ENV['YANDEX_API_KEY'])

    Phrase.all.untranslated.limit(limit).each{|phrase|
      phrase.update(
        :translated => (translator.translate phrase.source, to: 'ru')
      )
    }

  end

end
