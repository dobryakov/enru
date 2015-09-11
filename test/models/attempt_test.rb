require 'test_helper'

class AttemptTest < ActiveSupport::TestCase
  test "the truth" do

    user    = users(:one)
    attempt = user.next_attempt

    assert attempt.phrase = phrases(:one)

    attempt.translated = 'Это образец английского'
    attempt.save

    assert attempt.score = 0.25

  end
end
