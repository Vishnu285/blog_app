class User < ApplicationRecord
  has_many :posts, class_name: "Post", primary_key: :id, foreign_key: :author_id, dependent: :destroy

  def self.authenticate(options)
    user = self.find_by_email_address(options[:email_address])
    return nil unless user && user.authenticate(options[:password])
    user
  end

  def authenticate(password)
    return self.password_hash == User.encrypt(password)
  end

  protected
    def self.encrypt(password)
      Digest::SHA1.hexdigest(password.to_s)
    end
end
