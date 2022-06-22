class Post < ApplicationRecord
  belongs_to :user

  enum status: %i[PUBLIC PROTECTED PRIVATE PUBLIC_ARCHIVED PROTECTED_ARCHIVED PRIVATE_ARCHIVED DELETED]
end
