class Post < ApplicationRecord
  belongs_to :author, class_name: "User", primary_key: :id, foreign_key: :author_id
  has_many :comments, as: :commentable
  mount_base64_uploader :image, ImageUploader

  def self.build_from_json(json_params)
    post_params = get_post_params(json_params)
    author = User.find_by(:email_address => json_params["post"]["author_email_address"])
    post_id = json_params["post"]["id"]
    post = Post.find_by(:api_id => post_id) if post_id.present?
    post ||= Post.new
    post.assign_attributes(post_params)
    post.author = author
    post.comments.destroy_all
    json_params["post"]["comments"].each do |comment|
      user = User.find_by(:email_address => comment["user_email_address"])
      post.comments.build({content:comment["content"], commentable: post, user: user})
    end
    api_id = Post.maximum(:id) || 0
    post.api_id = "PS#{api_id.next}" unless post.api_id.present?
    post
  end

  def self.get_post_params(json_params)
    json_params["post"].permit(:title, :content, :image)
  end

end
