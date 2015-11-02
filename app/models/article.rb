class Article < ActiveRecord::Base
  attr_accessor :links

  belongs_to :author

  has_and_belongs_to_many :references,
    class_name: "Article",
    join_table: "article_references",
    foreign_key: "article_id",
    association_foreign_key: "referenced_article_id"

  validates :author, presence: true
  validates :url, presence: true, uniqueness: true

  def references_csv
    refs = self.references.map do |reference|
      "#{ reference.author.handle }, #{ reference.url }"
    end

    refs.join("\n")
  end
end
