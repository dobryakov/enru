class Attempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :phrase

  before_save do
    self.score = self.get_score
  end

  def get_diff
    Differ.diff_by_word(self.translated, self.phrase.translated)
  end

  def html_diff
    unless self.translated.nil?
      self.get_diff.format_as :html
    end
  end

  def get_score
    score = 0.0
    unless self.translated.nil?
      # compare with source and set score
      h = JSON.parse(self.get_diff.to_json)
      score = 1.0 / (h['raw'].count) if h['raw'].count > 0
    end
    score
  end

end
