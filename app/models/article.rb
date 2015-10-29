class Article < ActiveRecord::Base
  belongs_to :author

  has_and_belongs_to_many :references,
    class_name: "Article",
    join_table: "article_references",
    foreign_key: "article_id",
    association_foreign_key: "referenced_article_id"
end
