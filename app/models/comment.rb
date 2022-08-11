class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentables
  has_rich_text :content
  has_paper_trail
  acts_as_votable
end
