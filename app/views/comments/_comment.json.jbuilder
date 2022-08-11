json.extract! comment, :id, :user_id, :commentable_id, :status, :created_at, :updated_at
json.url comment_url(comment, format: :json)
