module Api
  module V1
    class ApiController < RocketPants::Base
      version 1

      PER_PAGE_NUMBER = 10

      before_action :authenticate!

      private

      def authenticate!
        error! :unauthenticated if params[:token].nil?
        @user = User.find_by(token: params[:token])
        error! :unauthenticated if @user.nil?
      end

    end
  end
end
