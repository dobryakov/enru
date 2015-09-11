class Phrase < ActiveRecord::Base
  belongs_to :feed
  has_many   :attempts

  scope :untranslated, -> { where(:translated => nil) }

end
