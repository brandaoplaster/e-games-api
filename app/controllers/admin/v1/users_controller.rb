# frozen_string_literal: true

module Admin
  module V1
    class UsersController < ApiController

      def index
        @users = User.where.not(id: @current_user.id)
      end
    end
  end
end
