class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentables
  has_rich_text :content
  has_paper_trail
  acts_as_votable

  def mutable_to?(user1)
    # TODO: admin user
    user1 && user == user1
  end

  # Path to create new comment to comment
  def new_comments_path
    "/comments/Comment/#{id}/new"
  end

  # Path to show comments of the comment
  def comments_path
    "/comments/Comment/#{id}"
  end
end

# DOM id for comment used in index page
def comment_dom_id(type, id, offset)
  "#{type}#{id}comments#{offset}offset"
end

# DOM id for new comment
def new_comment_dom_id(type, id)
  "#{type}#{id}new_comments"
end
