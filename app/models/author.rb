class Author < ActiveRecord::Base
  has_many :articles

  validates :handle, presence: true, uniqueness: true

  def identity
    "#{ self.name } (#{ self.handle })"
  end
end
