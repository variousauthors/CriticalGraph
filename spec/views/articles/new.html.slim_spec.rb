require 'rails_helper'

RSpec.describe "articles/new", type: :view do
  before(:each) do
    assign(:article, Article.new(
      :url => "MyString",
      :title => "MyString",
      :author_id => 1,
      :parent_id => 1
    ))
  end

  it "renders new article form" do
    render

    assert_select "form[action=?][method=?]", articles_path, "post" do

      assert_select "input#article_url[name=?]", "article[url]"

      assert_select "input#article_title[name=?]", "article[title]"

      assert_select "input#article_author_id[name=?]", "article[author_id]"

      assert_select "input#article_parent_id[name=?]", "article[parent_id]"
    end
  end
end
