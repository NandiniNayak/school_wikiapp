class Post < ApplicationRecord
  belongs_to :subject
  belongs_to :user
  acts_as_votable
  has_many :comments
  validates_presence_of :body, :title
  
  mount_uploader :image, PostImageUploader

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end
end
