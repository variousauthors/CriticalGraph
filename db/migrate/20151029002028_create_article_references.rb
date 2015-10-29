class CreateArticleReferences < ActiveRecord::Migration
  def self.up
    create_table :article_references, id: false do |t|
      t.integer :article_id
      t.integer :referenced_article_id
    end

    # add_index(:article_references, [:article_id, :referenced_article_id], :unique => true)
    # add_index(:article_references, [:referenced_article_id, :article_id], :unique => true)
  end

  def self.down
    # remove_index(:article_references, [:referenced_article_id, :article_id])
    # remove_index(:article_references, [:article_id, :referenced_article_id])
    drop_table :article_references
  end
end
