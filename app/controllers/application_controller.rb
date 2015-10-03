class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  PER_PAGE_NUMBER = 10
  NUMBER_OF_SUBREDDITS = 10

  before_action :authenticate_user!, :init_subreddits

  def init_subreddits
    if current_user
      @subreddits = current_user.subreddits.limit(NUMBER_OF_SUBREDDITS)
    end
  end
end
