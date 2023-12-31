# frozen_string_literal: true

module Admin
  module V1
    class UsersController < ApiController
      before_action :load_user, only: [:update, :show, :destroy]

      def index
        @users = User.where.not(id: @current_user.id)
      end

      def create
        @user = User.new
        @user.attributes = user_params
        save_user!
      end

      def update
        @user.attributes = user_params
        save_user!
      end

      def show; end

      def destroy
        @user.destroy!
      rescue
        render_error fields: @user.errors.messages
      end

      private

      def load_user
        @user = User.find(params[:id])
      end

      def user_params
        return {} unless params.has_key?(:user)
        params.require(:user).permit(:id, :name, :email, :password, :password_confirmation,
                                     :profile)
      end

      def save_user!
        @user.save!
        render :show
      rescue
        render_error fields: @user.errors.messages
      end
    end
  end
end
