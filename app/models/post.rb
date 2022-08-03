class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :content
  has_paper_trail

  # status of the user
  # ! only appending to the list allowed
  enum status: %i[PUBLIC PROTECTED PRIVATE PUBLIC_ARCHIVED PROTECTED_ARCHIVED PRIVATE_ARCHIVED DELETED REPORTED]

  # * status methods {
  def public?
    %w[PUBLIC PUBLIC_ARCHIVED].include? status
  end

  def mutable?
    %w[PUBLIC PROTECTED PRIVATE].include? status
  end

  def private_visible?
    %w[PUBLIC PROTECTED PRIVATE PUBLIC_ARCHIVED PROTECTED_ARCHIVED PRIVATE_ARCHIVED].include? status
  end

  def visible_to?(user)
    if user && user.id == user_id
      private_visible?
    # TODO: protected
    else
      public?
    end
  end

  def mutable_to?(user)
    if user
      user.id == user_id
    # TODO: protected
    else
      false
    end
  end
  # * } status methods

  # Number of content revisions
  def revisions
    content.versions.length
  end
end
