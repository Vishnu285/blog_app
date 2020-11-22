require 'rails_helper'

RSpec.describe Api::V1::PostsController do
  include AuthHelper
  render_views

  before(:each) do
    @user = User.create(email_address: 'test@test.com', name: 'test', password_hash: User.encrypt('test'))
    http_login
  end
  context 'with valid authentication' do
    it 'should create a post' do
      params = {
        post: {
          title: "First Post",
          content: "Test Content",
          author_email_address: @user.email_address,
          comments: [
            {
              content: "Good Post",
              user_email_address: @user.email_address
            }
          ]
        }
      }
      expect{post :create, params: params}.to change{Post.count}.by(1)
      post = Post.first
      expect(post.title).to eq "First Post"
    end
    it 'should update existing post' do
      post_1 = Post.create(title: "First Post", content: "Test Content", author: @user, api_id: "PS1")
      post :update, params: {
        id: post_1.api_id,
        format: 'json',
        post: {
          title: "First Post",
          content: "Modified Content",
          id: post_1.api_id,
          author_email_address: @user.email_address,
          comments: [
            {
              content: "Good Post",
              user_email_address: @user.email_address
            }
          ]
        }
      }
      expect(post_1.reload.content).to eq "Modified Content"
    end
  end
end