class Author < ActiveRecord::Base
  has_many :articles

  validates :handle, presence: true, uniqueness: true

  scope :alphabetically, lambda { |column_name = :handle|
    column = arel_table[column_name]

    where(column.not_eq(nil)).order(arel_table[column_name].asc)
  }

  def identity
    "#{ self.name } (#{ self.handle })"
  end
end
