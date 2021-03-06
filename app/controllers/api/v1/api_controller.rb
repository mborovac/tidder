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

      def authenticate2!
        error! :unauthenticated unless authenticate_with_http_token do |token, options|
          User.exists?(token: token)
        end
      end
    end
  end
end
