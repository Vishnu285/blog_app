# frozen_string_literal: true

module Api
  module V1
    class PostsController < Api::V1::ApiController
      before_action :load_post, only: %i[update destroy show]

      def index
        @posts = Post.includes(:comments)
      end

      def create
        @post = Post.build_from_json(params)
        if @post.valid?
          @post.save
          render json: { success: true, status: 200, id: @post.api_id }
        else
          render json: { success: false, status: 200, error_message: @post.errors.messages }
        end
      end

      def show; end

      def update
        @post = Post.build_from_json(params)
        if @post.valid?
          @post.save
          render 'show'
        else
          render json: { success: false, status: 200, error_message: @post.errors.messages }
        end
      end

      def destroy
        @post.destroy
        render json: { success: true, status: 200 }
      end

      private

      def load_post
        @post = Post.find_by(api_id: params[:id])
        unless @post
          render json: { success: false, status: 200, error_message: "No post exist with ID #{params[:id]}" } and return
        end
      end
    end
  end
end
