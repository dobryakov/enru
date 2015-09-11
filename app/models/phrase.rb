class Phrase < ActiveRecord::Base
  belongs_to :feed
  has_many   :attempts
end
