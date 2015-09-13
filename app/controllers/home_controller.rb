class HomeController < ApplicationController

  def go

    @user = User.first # @TODO current_user
    @attempt = @user.next_attempt

  end

end
