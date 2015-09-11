namespace :feeder do

  desc "Fetch RSS"
  task fetch: :environment do

    feed = Feed.order('updated_at ASC').first
    newest_phrase = feed.phrases.last

    unless feed.nil?

      rss = Feedjira::Feed.fetch_and_parse feed.url

      rss.entries.each{|e|

        published_at = e.published

        if published_at > ( newest_phrase.try(:created_at) || Time.now - 1.day )

          title   = ActionController::Base.helpers.sanitize e.title.to_s,   tags: []
          title.strip!

          Phrase.create(
            :feed => feed,
            :source => title
          ) unless title.to_s == ''

          summary = ActionController::Base.helpers.sanitize e.summary.to_s, tags: []
          summary = summary.tr("\n","").tr("\r","")

          summary.split('.').each{|p|
            p.strip!
            Phrase.create(
                :feed => feed,
                :source => p
            ) unless p.to_s == ''
          }

        end

        break

      }

    end

  end

end
