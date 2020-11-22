json.title @post.title
json.content @post.content
json.author_email_address @post.author.email_address
json.image @post.image

json.comments @post.comments do |comment|
  json.content comment.content
  json.user_email_address comment.user.email_address
end
